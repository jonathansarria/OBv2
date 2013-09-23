desc "Fetch classes for CECS"
task :fetch_classes => :environment do
  require 'nokogiri'
  require 'mechanize'
  
  def get_keys()
    # Dynamically get CsClass attribute keys just because
    # keys = [:Status, :CRN, :Course, :Sect, :PartTerm, :Title, :CrHrs, :BegDate, :EndDate, :Camp, :Days, :BegTime, :End_Time, :MeetType, :Bldg, :Room, :Seats, :Waitlist, :Aprv, :AddlFees, :Instructor]
    keys = CsClass.attribute_names
    # Remove id
    keys.shift
    # Remove timestamps
    keys.pop
    keys.pop
    # Convert strings to symbols
    keys.map(&:to_sym)
  end

  def get_values(table_rows)
    useful_trs = false
    colomns = Array.new
    rows = Array.new
    table_headers = Array.new
    
    table_rows.each do | tr |
      # Get nodes after input element
      if useful_trs
        tr.traverse do | node |
          case node.name
            when 'th'
              table_headers << node.text
            when 'tr'
              rows << colomns
              colomns = Array.new
            when 'text'
              unless node.to_s[/^\d. /]
                colomns << node.text if node.text != "\n"
              end
          end
        end
      end
      # Find node that contains the input button
      unless (tr.children>('input')).empty?
        useful_trs = true
      end
    end
    
    rows.delete_if { |colomn| colomn.empty? }
    # Can't use db keys as headers due to Seats and Waitlist interpreting as multiparameter
    rows[0] = table_headers
    return rows
  end

  browser = Mechanize.new
  
  url = "https://banner.fau.edu/FAUPdad/lwskdsch.p_dept_schd"
  
  # The post parameters for CS
  # pv_term=201308&pv_campus=01&pv_college=EG&pv_dept=CSCE&pv_level=UG
  params = {
    'pv_term' => "201308",
    'pv_campus' => "01",
    'pv_college' => "EG",
    'pv_dept' => "CSCE",
    'pv_level' => "UG"
  }
  
  page = browser.post(url, params)
  
  keys = get_keys()
  rows = get_values(page.search("tr"))

  rows.each do |colomn|
    CsClass.create(Hash[keys.zip(colomn)])
  end
end

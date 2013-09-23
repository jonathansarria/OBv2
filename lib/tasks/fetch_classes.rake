desc "Fetch classes for CECS"
task :fetch_classes => :environment do
  require 'nokogiri'
  require 'mechanize'
  
  browser = Mechanize.new
  
  url = "https://banner.fau.edu/FAUPdad/lwskdsch.p_dept_schd"
  
  # pv_term=201308&pv_campus=01&pv_college=EG&pv_dept=CSCE&pv_level=UG
  params = {
    'pv_term' => "201308",
    'pv_campus' => "01",
    'pv_college' => "EG",
    'pv_dept' => "CSCE",
    'pv_level' => "UG"
  }
  
  page = browser.post(url, params)
  
  elements = page.search(".dddefault")

  elements.each do |elm|
    CsClass.create(html: elm.to_s)
  end
end

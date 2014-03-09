require 'spec_helper'

describe RailsZero::CleanSiteJob do
  let('file_path') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  before do
    FileUtils.rm_rf(file_path)
    FileUtils.mkdir_p(File.dirname(file_path))
    FileUtils.touch(file_path)
  end
  after do
    FileUtils.rm_rf(file_path)
  end
  it 'queries all pages' do
    File.exists?(file_path).should be_true
    subject.run
    File.exists?(file_path).should be_false
    File.exists?(Rails.root.join('public', '404.html').to_s).should be_true
    File.exists?(Rails.root.join('public', '422.html').to_s).should be_true
    File.exists?(Rails.root.join('public', '500.html').to_s).should be_true
    File.exists?(Rails.root.join('public', 'favicon.ico').to_s).should be_true
  end
end
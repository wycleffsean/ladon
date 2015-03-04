require 'test_helper'


describe Ladon::Example::Authorization do
  let(:subject) { Ladon::Example::Authorization.new }

  it '#url' do
    subject.url.must_match /example.com/
  end
  
  describe '#form' do
    it '#duration' do
      subject.form.duration.must_match /permanent/
    end
    it '#redirect_uri' do
      subject.form.redirect_uri.must_match /callback/
    end
  end
end

require 'test_helper'

describe Ladon::Example do
  let(:subject) { Ladon::Example.new }

  describe 'configuration' do
    it '#application_id' do
      subject.application_id.must_match /id/
    end

    it '#application_secret' do
      subject.application_secret.must_match /secret/
    end
  end

  describe '#authorization_form' do
    let(:state) { 'secret' }
    let(:form) { subject.authorization_form(state) }
  end
end

require 'helper'
require 'json'

describe Afterbanks::Client do
  before do
    @test_credentials = { service_key: 'test_service_key',
                          service: 'test_service',
                          user: 'test_user',
                          pass: 'test_pass' }

    @client = Afterbanks::Client.new(@test_credentials)
  end

  describe '#service_key' do
    it 'returns the configured value' do
      expect(@client.service_key).to eq(@test_credentials[:service_key])
    end
  end

  describe '#service' do
    it 'returns the configured value' do
      expect(@client.service).to eq(@test_credentials[:service])
    end
  end

  describe '#user' do
    it 'returns the configured value' do
      expect(@client.user).to eq(@test_credentials[:user])
    end
  end

  describe '#pass' do
    it 'returns the configured value' do
      expect(@client.pass).to eq(@test_credentials[:pass])
    end
  end

  describe '#me' do
    let(:url) { "#{@client.configuration.endpoint}/me/" }
    let!(:request_stub) {
      stub_request(:post, url).
        with(body: { 'servicekey' => @test_credentials[:service_key] }).
        to_return(status: 200,
                  body: fixture('me.json'),
                  headers: { content_type: 'application/json; charset=utf-8'} )
    }

    after do
      remove_request_stub(request_stub)
    end

    it 'makes a request to the proper URL' do
      @client.me

      me_request = a_request(:post, url)
      expect(me_request).to have_been_made.times(1)
    end
  end

  describe '#forms' do
    let(:url) { "#{@client.configuration.endpoint}/forms/" }
    let!(:request_stub) {
      stub_request(:get, url).
        to_return(status: 200,
                  body: fixture('forms.json'),
                  headers: { content_type: 'application/json; charset=utf-8'} )
    }

    after do
      remove_request_stub(request_stub)
    end

    it 'makes a request to the proper URL' do
      @client.forms

      forms_request = a_request(:get, url)
      expect(forms_request).to have_been_made.times(1)
    end
  end

  describe '#products' do
    let(:url) { "#{@client.configuration.endpoint}/serviceV3/" }
    let!(:request_stub) {
      stub_request(:post, url).
        to_return(status: 200,
                  body: fixture('products.json'),
                  headers: { content_type: 'application/json; charset=utf-8'} )
    }

    after do
      remove_request_stub(request_stub)
    end

    it 'makes a request to the proper URL' do
      @client.products

      products_request = a_request(:post, url)
      expect(products_request).to have_been_made.times(1)
    end
  end

  describe '#transactions' do
    let(:product) { '0081-0060-00-0001234567' }

    it 'makes a request to the proper URL' do
      skip
      # @client.transactions(products: product)
    end
  end
end

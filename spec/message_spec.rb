require 'openpgp'

describe OpenPGP::Message, " at <http://ar.to/pgp.txt>" do
  before :each do
    @ascii = File.read(File.join(File.dirname(__FILE__), 'data', 'pgp.txt'))
  end

  context "when dearmored" do
    it "should return a binary string of 1,939 bytes" do
      lambda { @binary = OpenPGP.dearmor(@ascii) }.should_not raise_error
      @binary.should_not be_empty
      @binary.should be_a_kind_of(String)
      @binary.should have(1939).characters
    end

    it "should match the CRC24 checksum of ..." # TODO
  end

  context "when parsed" do
    it "should return a sequence of packets" do
      lambda { @message = OpenPGP::Message.parse(OpenPGP.dearmor(@ascii)) }.should_not raise_error
      @message.should be_a_kind_of(OpenPGP::Message)
      @message.packets.should have(9).items
    end

    it "should contain a public key packet"     # TODO
    it "should contain a public subkey packet"  # TODO
    it "should contain three user ID packets"   # TODO
  end
end

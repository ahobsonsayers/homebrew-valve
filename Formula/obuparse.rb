class Obuparse < Formula
  desc "A simple and portable single file AV1 OBU parser"
  homepage "https://github.com/dwbuiten/obuparse"
  license "ISC"
  head "https://github.com/dwbuiten/obuparse.git"
    
  def install
    system "make", "install", "PREFIX=#{prefix}"
    system "make", "install-tools", "PREFIX=#{prefix}"
  end
end

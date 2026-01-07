class LSmash < Formula
  desc "Cross-platform library that handles the ISO Base Media file format"
  homepage "https://github.com/vimeo/l-smash"
  license "ISC"
  head "https://github.com/vimeo/l-smash.git"

  depends_on "ahobsonsayers/valve/obuparse"

  def install
    ENV.append_to_cflags "-fPIC" if OS.linux?

    system "./configure", "--prefix=#{prefix}", "--extra-cflags=#{ENV.cflags}"
    system "make", "install"
  end
end

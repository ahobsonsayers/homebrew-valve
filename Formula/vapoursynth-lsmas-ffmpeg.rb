class VapoursynthLsmasFfmpeg < Formula
  desc "FFmpeg for the HomeOfAviSynthPlusEvolution lsmas Vapoursynth Plugin"
  homepage "https://github.com/HomeOfAviSynthPlusEvolution/FFmpeg"
  license "GPL-3.0-or-later"
  head "https://github.com/HomeOfAviSynthPlusEvolution/FFmpeg.git", branch: "custom-patches-for-lsmashsource"

  depends_on "pkg-config" => :build

  on_intel do
    depends_on "nasm" => :build
  end

  keg_only "avoid conflicts with upstream"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --enable-pthreads
      --enable-version3
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin / "ffmpeg", "-version"
  end
end

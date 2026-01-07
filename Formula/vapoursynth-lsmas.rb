class VapoursynthLsmas < Formula
  desc "VapourSynth plugin for l-smash"
  homepage "https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works"
  license "ISC"
  head "https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works.git", branch: "master"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "ahobsonsayers/valve/l-smash"
  depends_on "ffmpeg"
  depends_on "vapoursynth"
  depends_on "xxhash"

  def install
    Dir.chdir "VapourSynth" do

      # Upstream build system wants to install directly into vapoursynth's libdir and does not respect
      # prefix, but we want it in a Cellar location instead.
      inreplace "meson.build",
                "install_dir: join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')",
                "install_dir: '#{lib}/vapoursynth'"

      system "meson", "setup", "build", *std_meson_args
      system "meson", "compile", "-C", "build", "--verbose"
      system "meson", "install", "-C", "build"
    end
  end

  test do
    python = Formula["vapoursynth"].deps
                                   .find { |d| d.name.match?(/^python@\d\.\d+$/) }
                                   .to_formula
                                   .opt_libexec / "bin/python"
    system python, "-c", "from vapoursynth import core; core.lsmas"
  end
end

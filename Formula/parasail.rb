class Parasail < Formula
  # Daily_2016: "https://doi.org/10.1186/s12859-016-0930-z"
  desc "Pairwise Sequence Alignment Library"
  homepage "https://github.com/jeffdaily/parasail"
  url "https://github.com/jeffdaily/parasail/archive/v2.4.1.tar.gz"
  sha256 "a0cffa81251151d1038c89ec8c5105d2c4234b88d240015fee0244e26c2a739f"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "56654603399ca71fd04761e9410d2762cd69c70999d14ba37ef07a4791bf3991" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  if OS.mac?
    depends_on "gcc" # needs openmp
  else
    depends_on "zlib"
  end

  fails_with :clang # needs openmp

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--prefix=#{prefix}", "--disable-silent-rules", "--disable-dependency-tracking"
    system "make", "check"
    system "make", "install"
  end

  test do
    assert_match "gap_extend", shell_output("#{bin}/parasail_aligner -h 2>&1", 1)
    assert_match "Missing", shell_output("#{bin}/parasail_stats 2>&1", 1)
  end
end

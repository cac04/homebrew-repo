class Lowdown < Formula
	desc "simple Markdown translator"
	homepage "https://kristaps.bsd.lv/lowdown"
	url "https://kristaps.bsd.lv/lowdown/snapshots/lowdown-0.7.1.tar.gz"
	sha256 "02b48f90885cc2a8a375ef095da15954f2a2f3ece26bd6e13552b75906cd19e9"
	depends_on "kristapsdz/repo/libdiff" => :build
	def install
		system "./configure", "PREFIX=#{prefix}", "MANDIR=#{man}", "SHAREDIR=#{share}", "BINDIR=#{bin}", "INCLUDEDIR=#{include}", "LIBDIR=#{lib}"
		system "make", "install"
	end
end

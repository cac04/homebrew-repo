class Sblg < Formula
	desc "simple off-line blog utility"
	homepage "https://kristaps.bsd.lv/sblg"
	url "https://kristaps.bsd.lv/sblg/snapshots/sblg-0.5.9.tar.gz"
	sha256 "e53895cc9814cf2fa8f5f9e7be6b8f060f242a0486303713d4de7aa6c2ba8551"
	def install
		system "./configure", "PREFIX=#{prefix}", "MANDIR=#{man}", "SHAREDIR=#{share}", "BINDIR=#{bin}"
		system "make", "install"
	end
end

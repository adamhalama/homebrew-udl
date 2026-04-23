class Udl < Formula
  desc "Set up and sync local music libraries from SoundCloud and Spotify sources"
  homepage "https://github.com/adamhalama/music-library-sync"
  version "0.2.0"
  depends_on "scdl"
  depends_on "yt-dlp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-arm64.tar.gz"
      sha256 "fab4bf14cc69f19731d25d8640b39a425da49a2973cf0db974147c2c6df7a47e"
    else
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-amd64.tar.gz"
      sha256 "f191af7ec88776844dea82e7e6ed999694591eece5c6671a825c92e9e846eab5"
    end
  end

  def install
    bin.install "udl"
  end

  test do
    assert_match "udl version", shell_output("#{bin}/udl version")
    output = shell_output("#{bin}/udl doctor")
    assert_match "no sources configured yet", output
  end
end

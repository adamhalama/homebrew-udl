class Udl < Formula
  desc "Set up and sync local music libraries from SoundCloud and Spotify sources"
  homepage "https://github.com/adamhalama/music-library-sync"
  version "0.1.5"
  depends_on "scdl"
  depends_on "yt-dlp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-arm64.tar.gz"
      sha256 "7333ba325c9a9475dbf5593f833b5237bbd14d2e011808903e99b3e7a5db6b2f"
    else
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-amd64.tar.gz"
      sha256 "2c23f1bb5884ecf43b6726c77ded1161fbdb578def828f699d77000a16834306"
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

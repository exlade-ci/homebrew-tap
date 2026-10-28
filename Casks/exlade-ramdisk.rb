cask "exlade-ramdisk" do
  version "1.2.1"
  sha256 "c425bdf46b00f00d917fcb7dac42799d1703c31abb689839916f82163364fca3"

  url "https://www.exlade.com/downloads/Exlade-RamDisk.dmg"
  name "Exlade RamDisk"
  desc "RAM disks that keep their files between launches, with a command-line tool"
  homepage "https://www.exlade.com/"

  livecheck do
    url "https://www.exlade.com/checkupdate.xml"
    regex(/<Product\s+name="RamDisk\s+for\s+Mac"\s+version="([^"]+)"/i)
  end

  # The app downloads and installs its own updates; brew upgrade leaves it to them.
  auto_updates true
  depends_on macos: :sequoia

  app "Exlade RamDisk.app"
  binary "#{appdir}/Exlade RamDisk.app/Contents/Helpers/eramdisk"
  bash_completion "#{appdir}/Exlade RamDisk.app/Contents/Resources/completions/eramdisk.bash", target: "eramdisk"
  zsh_completion "#{appdir}/Exlade RamDisk.app/Contents/Resources/completions/_eramdisk"
  fish_completion "#{appdir}/Exlade RamDisk.app/Contents/Resources/completions/eramdisk.fish"

  uninstall quit: "com.exlade.RamDisk"

  zap trash: [
        "~/Library/Application Support/Exlade RamDisk",
        "~/Library/Caches/com.exlade.RamDisk",
        "~/Library/Group Containers/7S3G2D6BQ7.com.exlade.RamDisk",
        "~/Library/HTTPStorages/com.exlade.RamDisk",
        "~/Library/Preferences/com.exlade.RamDisk.plist",
        "~/Library/Saved Application State/com.exlade.RamDisk.savedState",
      ],
      rmdir: "~/Library/RamDisks"

  caveats <<~EOS
    Before uninstalling, choose Settings → General → Reset… in Exlade RamDisk:
    it puts back folders moved onto RAM disks and removes keychain items.
    "brew uninstall --zap" deletes what is needed to put those folders back.
  EOS
end

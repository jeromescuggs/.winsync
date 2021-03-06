
# Call up and import pshazz config
try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }

# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# alias set 
Set-Alias la Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# https://www.pornhub.com/playlist/62831542
# Helper function to show Unicode characters
function U
{
    param
    (
        [int] $Code
    )
 
    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }
 
    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }
 
    throw "Invalid character code $Code"
}



$Host.UI.RawUI.WindowTitle = "jrmtrm @ PS {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin)
{
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"


    function df {
        $colItems = Get-wmiObject -class "Win32_LogicalDisk" -namespace "root\CIMV2" `
        -computername localhost
    
        foreach ($objItem in $colItems) {
            write $objItem.DeviceID $objItem.Description $objItem.FileSystem `
                ($objItem.Size / 1GB).ToString("f3") ($objItem.FreeSpace / 1GB).ToString("f3")
    
        }
    }}
try { $null = Get-Command concfg -ea stop; concfg tokencolor -n enable } catch { }

function prompt
{
  $loc = Get-Location

  # Emulate standard PS prompt with location followed by ">"
  # $out = "PS $loc> "
  
  # Or prettify the prompt by coloring its parts
  Write-Host -NoNewline -ForegroundColor Cyan "JRM "
  Write-Host -NoNewline -ForegroundColor Yellow $loc
  $out = "> "

  # Check for ConEmu existance and ANSI emulation enabled
  if ($env:ConEmuANSI -eq "ON") {
    # Let ConEmu know when the prompt ends, to select typed
    # command properly with "Shift+Home", to change cursor
    # position in the prompt by simple mouse click, etc.
    $out += "$([char]27)]9;12$([char]7)"

    # And current working directory (FileSystem)
    # ConEmu may show full path or just current folder name
    # in the Tab label (check Tab templates)
    # Also this knowledge is crucial to process hyperlinks clicks
    # on files in the output from compilers and source control
    # systems (git, hg, ...)
    if ($loc.Provider.Name -eq "FileSystem") {
      $out += "$([char]27)]9;9;`"$($loc.Path)`"$([char]7)"
    }
  }

  return $out
}
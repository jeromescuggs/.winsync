
# Call up and import pshazz config
try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }

# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# alias set 
Set-Alias la Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope
Set-Alias vim nvim

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


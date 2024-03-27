# +--------------------------------------+
# | Fast Node Manager Garbage Collection |
# +--------------------------------------+

function Remove-FnmMultishells {

  $multishellsDir = [IO.DirectoryInfo]::new("${env:LOCALAPPDATA}\fnm_multishells")
  $noOtherPowerShells = (Get-Process -Name powershell | Where-Object -Property Id -ne -Value $PID).Count -eq 0
  if ($noOtherPowerShells -and $multishellsDir.Exists) {

    [IO.DirectoryInfo]$currentMultishell = $null
    if ([IO.Directory]::Exists("${env:FNM_MULTISHELL_PATH}")) {

      $currentMultishell = [IO.DirectoryInfo]::new("${env:FNM_MULTISHELL_PATH}")
    }

    foreach ($directory in $multishellsDir.EnumerateDirectories()) {

      if ($currentMultishell -ne $null -and $directory.FullName -eq $currentMultishell.FullName) {

        continue
      }

      $directory.Delete()
    }
  }
}

Remove-FnmMultishells



# +-------------------------+
# | Fast Node Manager Setup |
# +-------------------------+

function Add-FnmMultishell {

  if ([String]::IsNullOrWhiteSpace("${env:FNM_MULTISHELL_PATH}") -or -not [IO.Directory]::Exists("${env:FNM_MULTISHELL_PATH}")) {

    fnm env --corepack-enabled --shell power-shell --use-on-cd | Out-String | Invoke-Expression
  }
}

Add-FnmMultishell

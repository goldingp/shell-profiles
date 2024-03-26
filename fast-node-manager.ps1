# +--------------------------------------+
# | Fast Node Manager Garbage Collection |
# +--------------------------------------+

function Remove-FnmMultishells {

  $isRecursiveDeleteEnabled = $false

  if ((Test-Path -Path env:\FNM_MULTISHELL_PATH) -and (Test-Path -Path "${env:FNM_MULTISHELL_PATH}")) {

    (Get-Item -Path "${env:FNM_MULTISHELL_PATH}").Delete($isRecursiveDeleteEnabled)
  }

  $multishellsDir = Get-Item -Path "${env:LOCALAPPDATA}\fnm_multishells"
  $noOtherPowerShells = (Get-Process -Name powershell | Where-Object -Property Id -NE -Value $PID).Count -eq 0
  if ($noOtherPowerShells -and $multishellsDir.Exists) {

    foreach ($directory in $multishellsDir.EnumerateDirectories()) {

      $directory.Delete($isRecursiveDeleteEnabled)
    }
  }
}

Remove-FnmMultishells



# +-------------------------+
# | Fast Node Manager Setup |
# +-------------------------+

function Add-FnmMultishell {

  fnm env --corepack-enabled --shell power-shell --use-on-cd | Out-String | Invoke-Expression
}

Add-FnmMultishell

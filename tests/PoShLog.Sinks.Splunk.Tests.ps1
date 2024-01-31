Describe "Import module" {
  It "imports the module" {
    {
      Import-Module "$PSScriptRoot\..\src\PoShLog.Sinks.Splunk.psm1" -Force
    } | Should -Not -Throw
  }
  It "imports the module using manifest" {
    {
      Import-Module "$PSScriptRoot\..\src\PoShLog.Sinks.Splunk.psd1" -Force
    } | Should -Not -Throw
  }
}

Describe "Cmdlet tests" {
  Context "Test for exceptions" {
    It "should create a new logger without throwing" {
      {
        New-Logger |
          Add-SinkSplunk -SplunkHost 'http://localhost:8088' -EventCollectorToken 'abc123' |
          Start-Logger
      } | Should -Not -Throw
    }
    It "should write a verbose log without throwing" {
      { Write-VerboseLog 'Test verbose message' } | Should -Not -Throw
    }
    It "should write a debug log without throwing" {
      { Write-DebugLog 'Test Debug message' } | Should -Not -Throw
    }
    It "should write a info log without throwing" {
      { Write-InfoLog 'Test info message' } | Should -Not -Throw
    }
    It "should write a warning log without throwing" {
      { Write-WarningLog 'Test warning message' } | Should -Not -Throw
    }
    It "should write a error log without throwing" {
      { Write-ErrorLog 'Test error message' } | Should -Not -Throw
    }
    It "should write a fatal log without throwing" {
      { Write-FatalLog 'Test fatal message' } | Should -Not -Throw
    }
    It "should display formatted output without throwing" {
      {
        $position = @{
          Latitude  = 25
          Longitude = 134
        }
        $elapsedMs = 34
        Write-InfoLog 'Processed {@Position} in {Elapsed:000} ms.' -PropertyValues $position, $elapsedMs
      } | Should -Not -Throw
    }

    It "should close logger without throwing" {
      { Close-Logger } | Should -Not -Throw
    }
  }

}

if (Get-Module PoShLog.Sinks.Splunk -ErrorAction SilentlyContinue) {
  Remove-Module PoShLog.Sinks.Splunk
}
if (Get-Module PoShLog -ErrorAction SilentlyContinue) {
  Remove-Module PoShLog
}

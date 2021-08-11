using namespace System.Net
param($Request, $TriggerMetadata)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Off

Write-Verbose '/ingestion function has been triggered' -Verbose
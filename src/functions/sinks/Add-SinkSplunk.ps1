function Add-SinkSplunk {
	<#
	.SYNOPSIS
		Adds a sink that writes log events to a Splunk instance via the HTTP Event Collector.

	.DESCRIPTION
		This function adds a sink that writes log events to a Splunk instance using the HTTP Event Collector.
		It requires the configuration, Splunk host, event collector token, and other optional parameters to be provided.

	.PARAMETER LoggerConfig
		The logger configuration to add this sink to.

	.PARAMETER SplunkHost
		The Splunk host that is configured with an Event Collector.

	.PARAMETER EventCollectorToken
		The token provided to authenticate to the Splunk Event Collector.

	.PARAMETER UriPath
		(Optional) Change the default endpoint of the Event Collector, e.g., services/collector/event.

	.PARAMETER Source
		(Optional) The source of the event.

	.PARAMETER SourceType
		(Optional) The source type of the event.

	.PARAMETER HostName
		(Optional) The host that generated the event.

	.PARAMETER Index
		(Optional) The Splunk index to log to.

	.PARAMETER RestrictedToMinimumLevel
		(Optional) The minimum log event level required in order to write an event to the sink.

	.PARAMETER FormatProvider
		(Optional) Supplies culture-specific formatting information, or null.

	.PARAMETER DontRenderTemplate
		(Optional) If supplied, the message template will not be rendered.

	.PARAMETER BatchIntervalInSeconds
		(Optional) The interval in seconds that the queue should be inspected for batching.

	.PARAMETER BatchSizeLimit
		(Optional) The size of the batch.

	.PARAMETER QueueLimit
		(Optional) Maximum number of events in the queue.

	.PARAMETER HttpMessageHandler
		(Optional) The handler used to send HTTP requests.

	.PARAMETER LevelSwitch
		(Optional) A switch allowing the pass-through minimum level to be changed at runtime.

	#>

	[OutputType([Serilog.LoggerConfiguration])]
	[Cmdletbinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[Serilog.LoggerConfiguration]$LoggerConfig,

		[Parameter(Mandatory = $true)]
		[string]$SplunkHost,

		[Parameter(Mandatory = $true)]
		[string]$EventCollectorToken,

		[Parameter(Mandatory = $false)]
		[string]$UriPath = "services/collector",

		[Parameter(Mandatory = $false)]
		[string]$Source = '',

		[Parameter(Mandatory = $false)]
		[string]$SourceType = '',

		[Parameter(Mandatory = $false)]
		[string]$HostName = '',

		[Parameter(Mandatory = $false)]
		[string]$Index = '',

		[Parameter(Mandatory = $false)]
		[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel = [Serilog.Events.LevelAlias]::Minimum,

		[Parameter(Mandatory = $false)]
		[System.IFormatProvider]$FormatProvider = $null,

		[Parameter(Mandatory = $false)]
		[switch]$DontRenderTemplate = $false,

		[Parameter(Mandatory = $false)]
		[int]$BatchIntervalSeconds = 2,

		[Parameter(Mandatory = $false)]
		[int]$BatchSizeLimit = 100,

		[Parameter(Mandatory = $false)]
		[Nullable[int]]$QueueLimit = $null,

		[Parameter(Mandatory = $false)]
		[System.Net.Http.HttpMessageHandler]$HttpMessageHandler = $null,

		[Parameter(Mandatory = $false)]
		[Serilog.Core.LoggingLevelSwitch]$LevelSwitch = $null

	)

	$LoggerConfig = [Serilog.SplunkLoggingConfigurationExtensions]::EventCollector(
		$LoggerConfig.WriteTo,
		$SplunkHost,
		$EventCollectorToken,
		$UriPath,
		$Source,
		$SourceType,
		$HostName,
		$Index,
		$RestrictedToMinimumLevel,
		$FormatProvider,
		!$DontRenderTemplate,
		$BatchIntervalSeconds,
		$BatchSizeLimit,
		$QueueLimit,
		$HttpMessageHandler,
		$LevelSwitch
	)

	$LoggerConfig

}

<?xml version="1.0" encoding="UTF-8"?>

<ModuleContainer version="4">
   <modules>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">false</parameter>
            <parameter name="Label">Original file size: 7.91 G</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">1. Covert to EK500 format: FM: 5.97G; =&gt;CW 0.99G; CW + angle513M; </parameter>
            <parameter name="Comment">Convert complex data to real data, i.e. convert from EK80 to EK60 format. CW-data is then reduced to 1/8 of the volume.</parameter>
         </parameters>
      </module>
      <module name="ComplexToRealModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="ComputeAngles">true</parameter>
            <parameter name="KeepBroadband">false</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">2. Remove angles - not needed (incorporated in ComplexToReal)</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="AngleDeletionModule">
         <parameters>
            <parameter name="Active">false</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">3. Channel data removal (not needed)</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="ChannelDataRemovalModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Channels"/>
            <parameter name="ChannelsFromEnd"/>
            <parameter name="Frequencies"/>
            <parameter name="DataType"/>
            <parameter name="TransmitMode"/>
            <parameter name="PingId"/>
            <parameter name="KeepSpecified">false</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">4. Channnel removal (not needed)</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="ChannelRemovalModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="Channels"/>
            <parameter name="ChannelsFromEnd"/>
            <parameter name="Frequencies"/>
            <parameter name="DataType"/>
            <parameter name="TransmitMode"/>
            <parameter name="PingId"/>
            <parameter name="KeepSpecified">false</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">5A. Data reduction: fixed upper-lower limits</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="DataReductionModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="BlindZone">true</parameter>
            <parameter name="MinRange"/>
            <parameter name="MinDepth"/>
            <parameter name="TransducerRange">true</parameter>
            <parameter name="MaxRange"/>
            <parameter name="MaxDepth"/>
            <parameter name="MaxBelowBottom"/>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">5B. Data reduction: remove below bottom</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="GroupStart">true</parameter>
            <parameter name="GroupCollapsed">false</parameter>
            <parameter name="LineBreak">false</parameter>
            <parameter name="Label">Bottom detection</parameter>
            <parameter name="Comment">All changes of data between TemporaryComputationsBeginModule and TemporaryComputationsEndModule are discarded, but new telegrams are kept.
In this case the data are smoothed heavily horizontally to get a stable bottom detection, but such heavily smoothed data are not desired after the bottom
is detected. The bottom telegram are kept after TemporaryComputationsEndModule.</parameter>
         </parameters>
      </module>
      <module name="TemporaryComputationsBeginModule">
         <parameters>
            <parameter name="Active">true</parameter>
         </parameters>
      </module>
      <module name="SmootherModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="OnlyLastChannel">false</parameter>
            <parameter name="MaskPelagic">false</parameter>
            <parameter name="MaskBottom">false</parameter>
            <parameter name="MaskSecondBottom">true</parameter>
            <parameter name="MaskNoise">false</parameter>
            <parameter name="MaskRegion">none</parameter>
            <parameter name="MaskTrack">none</parameter>
            <parameter name="MinPing">0</parameter>
            <parameter name="MaxPing">1</parameter>
            <parameter name="HorizontalKernelType">gaussian</parameter>
            <parameter name="VerticalKernelType">gaussian</parameter>
            <parameter name="HorizontalWidth">10</parameter>
            <parameter name="VerticalWidth">1E-15</parameter>
            <parameter name="LogarithmicValues">false</parameter>
         </parameters>
      </module>
      <module name="DepthModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Algorithm">EK500</parameter>
            <parameter name="MinDepthLimit">10</parameter>
            <parameter name="MinDepthValueFraction">0.001</parameter>
            <parameter name="SignalStrengthThreshold">-31</parameter>
            <parameter name="MinimumDepthThresholdFactor">0.99</parameter>
            <parameter name="MaxRangeFactor">1.5</parameter>
            <parameter name="AlwaysDetectBottom">true</parameter>
            <parameter name="MinBottomDepth">500</parameter>
            <parameter name="MaxBottomDepth">2500</parameter>
            <parameter name="PreferredKHz"/>
            <parameter name="MinKHz">10</parameter>
            <parameter name="MaxKHz">50</parameter>
            <parameter name="DoNotUseKHz"/>
         </parameters>
      </module>
      <module name="TemporaryComputationsEndModule">
         <parameters>
            <parameter name="Active">true</parameter>
         </parameters>
      </module>
      <module name="GroupEndModule">
         <parameters>
            <parameter name="Active">true</parameter>
         </parameters>
      </module>
      <module name="DataReductionModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="BlindZone">false</parameter>
            <parameter name="MinRange"/>
            <parameter name="MinDepth"/>
            <parameter name="TransducerRange">false</parameter>
            <parameter name="MaxRange"/>
            <parameter name="MaxDepth"/>
            <parameter name="MaxBelowBottom">0</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">6. Downsampling to 3 cm</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="DownsamplingModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Downsampling">SAMPLE_SIZE</parameter>
            <parameter name="DownsamplingFactor">1</parameter>
            <parameter name="DownsamplingSampleSize">0.03</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">7. Echo line compression</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="GroupStart">true</parameter>
            <parameter name="GroupCollapsed">false</parameter>
            <parameter name="LineBreak">false</parameter>
            <parameter name="Label">Ambiant noise removal</parameter>
            <parameter name="Comment">The data are smoothed slightly. There are two smooth modules to avoid smoothing through the bottom.
Much smoothing reduce variance and improves the maximum usable range of the data, but that also reduce the spatial resolution.
The acoustic categorization library was originally generated for data smoothed over 8 m horizontally and 0.5 m vertically.</parameter>
         </parameters>
      </module>
      <module name="DownsamplingModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Downsampling">SAMPLE_SIZE</parameter>
            <parameter name="DownsamplingFactor">1</parameter>
            <parameter name="DownsamplingSampleSize">0.1</parameter>
         </parameters>
      </module>
      <module name="NoiseQuantificationModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Smooth">running averager</parameter>
            <parameter name="SmoothInterval">5</parameter>
            <parameter name="Mask">dynamic</parameter>
            <parameter name="MinimumQuality">100</parameter>
            <parameter name="ThresholdMasking">false</parameter>
            <parameter name="Threshold">-80</parameter>
            <parameter name="Histogram">geometric</parameter>
            <parameter name="UseTimeStepBuffer">true</parameter>
            <parameter name="TimeStepBufferMaxSize">50</parameter>
            <parameter name="HistogramInitializationCellCount">500</parameter>
            <parameter name="HistogramMaximumCellCount">2000</parameter>
            <parameter name="HistogramInitializationSampleCount">5000</parameter>
            <parameter name="HistogramMinimumSampleCount">20000</parameter>
            <parameter name="HistogramSmooth">true</parameter>
            <parameter name="HistogramSmoothFactor">100</parameter>
            <parameter name="SdevMasking">false</parameter>
            <parameter name="Sdev">10</parameter>
            <parameter name="SNMasking">false</parameter>
            <parameter name="SNRatio">10</parameter>
            <parameter name="UseFallbackNoiseQuantile">false</parameter>
            <parameter name="FallbackNoiseQuantile">5</parameter>
            <parameter name="FallbackNoiseChannels">true</parameter>
            <parameter name="WritePlotParameters">false</parameter>
         </parameters>
      </module>
      <module name="NoiseVisualizationModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="TimeSeriesLength">200</parameter>
            <parameter name="HistogramSpan">3</parameter>
            <parameter name="MedianSampleCount">500</parameter>
         </parameters>
      </module>
      <module name="NoiseRemoverModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="RemoveNoiseFromStart">true</parameter>
            <parameter name="MaxBufferSize">50</parameter>
            <parameter name="SampleSizeCorrection"/>
         </parameters>
      </module>
      <module name="GroupEndModule">
         <parameters>
            <parameter name="Active">true</parameter>
         </parameters>
      </module>
      <module name="EchoLineCompressionModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Threshold">-82</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">8. Empty ping removal</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="EmptyPingRemovalModule">
         <parameters>
            <parameter name="Active">false</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">9. Ping thinning: avoid using</parameter>
            <parameter name="Comment"/>
         </parameters>
      </module>
      <module name="PingThinningModule">
         <parameters>
            <parameter name="Active">false</parameter>
            <parameter name="PingsToSkipInitially">0</parameter>
            <parameter name="PingsToSkip">0</parameter>
         </parameters>
      </module>
      <module name="CommentModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="LineBreak">true</parameter>
            <parameter name="VerticalSpace">8</parameter>
            <parameter name="Label">All compression modules: 38 M</parameter>
            <parameter name="Comment">Facor: 213</parameter>
         </parameters>
      </module>
   </modules>
</ModuleContainer>

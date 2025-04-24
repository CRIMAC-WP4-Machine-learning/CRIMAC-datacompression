<?xml version="1.0" encoding="UTF-8"?>

<ModuleContainer version="4">
   <modules>
      <module name="ComplexToRealModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="ComputeAngles">false</parameter>
            <parameter name="KeepBroadband">false</parameter>
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
            <parameter name="MinBottomDepth">20</parameter>
            <parameter name="MaxBottomDepth">2500</parameter>
            <parameter name="PreferredKHz"/>
            <parameter name="MinKHz">10</parameter>
            <parameter name="MaxKHz">200</parameter>
            <parameter name="DoNotUseKHz"/>
         </parameters>
      </module>
      <module name="TemporaryComputationsEndModule">
         <parameters>
            <parameter name="Active">true</parameter>
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
      <module name="NoiseQuantificationModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Smooth">running averager</parameter>
            <parameter name="SmoothInterval">5</parameter>
            <parameter name="Mask">dynamic</parameter>
            <parameter name="MinimumQuality">25</parameter>
            <parameter name="ThresholdMasking">false</parameter>
            <parameter name="Threshold">-80</parameter>
            <parameter name="Histogram">geometric</parameter>
            <parameter name="UseTimeStepBuffer">true</parameter>
            <parameter name="TimeStepBufferMaxSize">50</parameter>
            <parameter name="HistogramInitializationCellCount">500</parameter>
            <parameter name="HistogramMaximumCellCount">2000</parameter>
            <parameter name="HistogramInitializationSampleCount">1000</parameter>
            <parameter name="HistogramMinimumSampleCount">20000</parameter>
            <parameter name="HistogramSmooth">true</parameter>
            <parameter name="HistogramSmoothFactor">100</parameter>
            <parameter name="SdevMasking">false</parameter>
            <parameter name="Sdev">10</parameter>
            <parameter name="SNMasking">false</parameter>
            <parameter name="SNRatio">10</parameter>
            <parameter name="UseFallbackNoiseQuantile">true</parameter>
            <parameter name="FallbackNoiseQuantile">5</parameter>
            <parameter name="FallbackNoiseChannels">f&lt;30</parameter>
            <parameter name="WritePlotParameters">false</parameter>
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
      <module name="EchoLineCompressionModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="Threshold">-70</parameter>
         </parameters>
      </module>
      <module name="DataReductionModule">
         <parameters>
            <parameter name="Active">true</parameter>
            <parameter name="BlindZone">false</parameter>
            <parameter name="MinRange">1</parameter>
            <parameter name="MinDepth"/>
            <parameter name="TransducerRange">true</parameter>
            <parameter name="MaxRange"/>
            <parameter name="MaxDepth"/>
            <parameter name="MaxBelowBottom">1</parameter>
         </parameters>
      </module>
   </modules>
</ModuleContainer>

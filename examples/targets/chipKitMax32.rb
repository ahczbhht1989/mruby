# Cross Compiling configuration for Digilent chipKIT Max32
# http://www.digilentinc.com/Products/Detail.cfm?Prod=CHIPKIT-MAX32
#
# Requires MPIDE (https://github.com/chipKIT32/chipKIT32-MAX)
#
# This configuration is based on @kyab's version
# http://d.hatena.ne.jp/kyab/20130201
MRuby::CrossBuild.new("chipKitMax32") do |conf|
  toolchain :gcc

  # Mac OS X
  # MPIDE_PATH = '/Applications/mpide.app/Contents/Resources/Java'
  # GNU Linux
  MPIDE_PATH = '/home/daniel/Downloads/mpide-0023-linux-20120903'

  PIC32_PATH = "#{MPIDE_PATH}/hardware/pic32"  

  conf.cc do |cc|
    cc.command="#{PIC32_PATH}/compiler/pic32-tools/bin/pic32-gcc"
    cc.include_paths = ["#{PIC32_PATH}/cores/pic32",
                        "#{PIC32_PATH}/variants/Max32",
                        "#{MRUBY_ROOT}/include"]
    cc.flags << "-O2 -mno-smart-io -w -ffunction-sections -fdata-sections -g -mdebugger -Wcast-align " +
                "-fno-short-double -mprocessor=32MX795F512L -DF_CPU=80000000L -DARDUINO=23 -D_BOARD_MEGA_ " +
                "-DMPIDEVER=0x01000202 -DMPIDE=23"
    cc.compile_options = "%{flags} -o %{outfile} -c %{infile}"
  end

  conf.archiver do |archiver|
    archiver.command = "#{PIC32_PATH}/compiler/pic32-tools/bin/pic32-ar"
    archiver.archive_options = 'rcs %{outfile} %{objs}'
  end

  # No binaries necessary
  conf.bins = []
end

require 'test_helper'

class TurboStreamer::CaptureTest < ActiveSupport::TestCase

  test "_capture" do
    builder = TurboStreamer.new
    capture = nil

    builder.object! do
      builder.key1 'value1'
      capture = builder.__send__(:_capture) do
        builder.key2 'value2'
        builder.key4 'value4'
      end
      builder.key3 'value3'
    end

    # Strip here because OJ adds new lines for unkown reasons
    # TODO: this could break parsers that don't allowing trailing whitespace,
    # it would be nice to configure or fix OJ to not output the newline
    assert_equal '"key2":"value2","key4":"value4"', capture.strip
    assert_equal '{"key1":"value1","key3":"value3"}', builder.target!.strip
  end

end

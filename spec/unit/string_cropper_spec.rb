# coding: UTF-8

require 'spec_helper'

describe PushBuilder::StringCropper do
  describe '#crop_bytes' do
    def crop_bytes(string, bytes, indicator='')
      PushBuilder::StringCropper.new(string, indicator).crop_bytes(bytes)
    end

    specify { crop_bytes('abcdefg', -1).    should eq 'abcdefg' }
    specify { crop_bytes('abcdefg', 0).     should eq 'abcdefg' }
    specify { crop_bytes('abcdefg', 1).     should eq 'abcdef'  }
    specify { crop_bytes('abcdefg', 1, '…').should eq 'abc…'    }
    specify { crop_bytes('abcdefg', 4, '…').should eq '…'       }

    specify { crop_bytes('aäoöuüe', 2).     should eq 'aäoöu' }
    specify { crop_bytes('aäoöuüe', 3).     should eq 'aäoöu' }
    specify { crop_bytes('aäoöuüe', 4).     should eq 'aäoö'  }
    specify { crop_bytes('aäoöuüe', 5).     should eq 'aäo'   }
    specify { crop_bytes('aäoöuüe', 1, '…').should eq 'aäoö…' }
    specify { crop_bytes('aäoöuüe', 2, '…').should eq 'aäo…'  }
    specify { crop_bytes('aäoöuüe', 3, '…').should eq 'aäo…'  }
    specify { crop_bytes('aäoöuüe', 4, '…').should eq 'aä…'   }
  end
end

#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Top Block
# Generated: Wed Dec  5 19:37:37 2018
##################################################


from gnuradio import analog
from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import filter
from gnuradio import gr
from gnuradio import iio
from gnuradio import zeromq
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser


class top_block(gr.top_block):

    def __init__(self):
        gr.top_block.__init__(self, "Top Block")

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 48000*24
        self.freq = freq = int(96.9e6)

        ##################################################
        # Blocks
        ##################################################
        self.zeromq_pub_sink_0 = zeromq.pub_sink(gr.sizeof_float, 1, 'tcp://0.0.0.0:5555', 100, False, -1)
        self.pluto_source_0 = iio.pluto_source('local:', freq, samp_rate, 20000000, 0x8000, True, True, True, "manual", 55, '', True)
        self.low_pass_filter_0 = filter.fir_filter_ccf(6, firdes.low_pass(
        	1, samp_rate, 100000, 100000, firdes.WIN_HAMMING, 6.76))
        self.blocks_null_sink_0 = blocks.null_sink(gr.sizeof_float*1)
        self.analog_wfm_rcv_0 = analog.wfm_rcv(
        	quad_rate=samp_rate/6,
        	audio_decimation=8,
        )



        ##################################################
        # Connections
        ##################################################
        self.connect((self.analog_wfm_rcv_0, 0), (self.blocks_null_sink_0, 0))
        self.connect((self.analog_wfm_rcv_0, 0), (self.zeromq_pub_sink_0, 0))
        self.connect((self.low_pass_filter_0, 0), (self.analog_wfm_rcv_0, 0))
        self.connect((self.pluto_source_0, 0), (self.low_pass_filter_0, 0))

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.pluto_source_0.set_params(self.freq, self.samp_rate, 20000000, True, True, True, "manual", 55, '', True)
        self.low_pass_filter_0.set_taps(firdes.low_pass(1, self.samp_rate, 100000, 100000, firdes.WIN_HAMMING, 6.76))

    def get_freq(self):
        return self.freq

    def set_freq(self, freq):
        self.freq = freq
        self.pluto_source_0.set_params(self.freq, self.samp_rate, 20000000, True, True, True, "manual", 55, '', True)


def main(top_block_cls=top_block, options=None):

    tb = top_block_cls()
    tb.start()
    try:
        raw_input('Press Enter to quit: ')
    except EOFError:
        pass
    tb.stop()
    tb.wait()


if __name__ == '__main__':
    main()

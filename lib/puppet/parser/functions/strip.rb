#
# strip.rb
#
# Copyright 2012 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Puppet::Parser::Functions
  newfunction(:strip, :type => :rvalue, :doc => <<-EOS
Return either a new array or string by removing leading and trailing whitespace
characters from elements within.

Prototype:

    strip(x)

Where x is either an array type or string value.

For example:

  Given the following statements:

    $a = 'abc '
    $b = ' def '
    $c = [' gh', ' i ', 'j ']

    notice strip($a)
    notice strip($b)
    notice dump($b)
    notice dump(strip($b))
    notice dump($c)
    notice dump(strip($c))

  The result will be as follows:

    notice: Scope(Class[main]): abc
    notice: Scope(Class[main]): def
    notice: Scope(Class[main]): " def "
    notice: Scope(Class[main]): "def"
    notice: Scope(Class[main]): [" gh", " i ", "j "]
    notice: Scope(Class[main]): ["gh", "i", "j"]
    EOS
  ) do |*arguments|
    #
    # This is to ensure that whenever we call this function from within
    # the Puppet manifest or alternatively form a template it will always
    # do the right thing ...
    #
    arguments = arguments.shift if arguments.first.is_a?(Array)

    raise Puppet::ParseError, "strip(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)" if arguments.size < 1

    value = arguments.shift

    unless [Array, String].include?(value.class)
      raise Puppet::ParseError, 'strip(): Requires either array type ' +
        'or string value to work with'
    end

    if value.is_a?(Array)
      value.collect { |i| i.is_a?(String) ? i.strip : i }
    else
      value.strip
    end
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8

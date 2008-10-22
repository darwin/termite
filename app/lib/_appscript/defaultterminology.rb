#!/usr/local/bin/ruby
# Copyright (C) 2006 HAS. 
# Released under MIT License.

module MRADefaultTerminology
	# Defines built-in terminology available for any application. When constructing the terminology tables for a particular application, the Terminology module will duplicate these tables and then add application-specific terms to create the finished lookup tables.

	Types = {
		'****' => :anything,
		
		'bool' => :boolean,
		
		'shor' => :short_integer,
		'long' => :integer,
		'magn' => :unsigned_integer,
		'comp' => :double_integer,
		
		'fixd' => :fixed,
		'lfxd' => :long_fixed,
		'decm' => :decimal_struct,
		
		'sing' => :short_float,
		'doub' => :float,
		'exte' => :extended_float,
		'ldbl' => :float_128bit,
		
		'TEXT' => :string,
		'cstr' => :c_string,
		'pstr' => :pascal_string,
		'STXT' => :styled_text,
		'tsty' => :text_style_info,
		'styl' => :styled_clipboard_text,
		'encs' => :encoded_string,
		'psct' => :writing_code,
		'intl' => :international_writing_code,
		'itxt' => :international_text,
		'sutx' => :styled_unicode_text,
		'utxt' => :unicode_text,
  		'utf8' => :utf8_text, # typeUTF8Text
		'ut16' => :utf16_text, # typeUTF16ExternalRepresentation
		
		'vers' => :version,
		'ldt ' => :date,
		'list' => :list,
		'reco' => :record,
		'rdat' => :data,
		'scpt' => :script,
		
		'insl' => :location_reference,
		'obj ' => :reference,
		
		'alis' => :alias,
		'fsrf' => :file_ref,
		'fss ' => :file_specification,
		'furl' => :file_url,
		
		'QDpt' => :point,
		'qdrt' => :bounding_rectangle,
		'fpnt' => :fixed_point,
		'frct' => :fixed_rectangle,
		'lpnt' => :long_point,
		'lrct' => :long_rectangle,
		'lfpt' => :long_fixed_point,
		'lfrc' => :long_fixed_rectangle,
		
		'EPS ' => :EPS_picture,
		'GIFf' => :GIF_picture,
		'JPEG' => :JPEG_picture,
		'PICT' => :PICT_picture,
		'TIFF' => :TIFF_picture,
		'cRGB' => :RGB_color,
		'tr16' => :RGB16_color,
		'tr96' => :RGB96_color,
		'cgtx' => :graphic_text,
		'clrt' => :color_table,
		'tpmm' => :pixel_map_record,
		
		'best' => :best,
		'type' => :type_class,
		'enum' => :enumerator,
		'prop' => :property,
		
		# AEAddressDesc types
		
		'port' => :mach_port,
		'kpid' => :kernel_process_id,
		'bund' => :application_bundle_id,
		'psn ' => :process_serial_number,
		'sign' => :application_signature,
		'aprl' => :application_url,
		
		# misc.
		
		'msng' => :missing_value,
		
		'pcls' => :class_,
		
		'null' => :null,
		
		'mLoc' => :machine_location,
		'mach' => :machine,
		
		'tdas' => :dash_style,
		'trot' => :rotation,
		
		'suin' => :suite_info,
		'gcli' => :class_info,
		'pinf' => :property_info,
		'elin' => :element_info,
		'evin' => :event_info,
		'pmin' => :parameter_info,
		
		# unit types
		
		'cmtr' => :centimeters,
		'metr' => :meters,
		'kmtr' => :kilometers,
		'inch' => :inches,
		'feet' => :feet,
		'yard' => :yards,
		'mile' => :miles,
		
		'sqrm' => :square_meters,
		'sqkm' => :square_kilometers,
		'sqft' => :square_feet,
		'sqyd' => :square_yards,
		'sqmi' => :square_miles,
		
		'ccmt' => :cubic_centimeters,
		'cmet' => :cubic_meters,
		'cuin' => :cubic_inches,
		'cfet' => :cubic_feet,
		'cyrd' => :cubic_yards,
		
		'litr' => :liters,
		'qrts' => :quarts,
		'galn' => :gallons,
		
		'gram' => :grams,
		'kgrm' => :kilograms,
		'ozs ' => :ounces,
		'lbs ' => :pounds,
		
		'degc' => :degrees_Celsius,
		'degf' => :degrees_Fahrenheit,
		'degk' => :degrees_Kelvin,
		
		# month and weekday
		
		'jan ' => :January,
		'feb ' => :February,
		'mar ' => :March,
		'apr ' => :April,
		'may ' => :May,
		'jun ' => :June,
		'jul ' => :July,
		'aug ' => :August,
		'sep ' => :September,
		'oct ' => :October,
		'nov ' => :November,
		'dec ' => :December,
		
		'sun ' => :Sunday,
		'mon ' => :Monday,
		'tue ' => :Tuesday,
		'wed ' => :Wednesday,
		'thu ' => :Thursday,
		'fri ' => :Friday,
		'sat ' => :Saturday,
	}
	
	Enumerators = {
		'yes ' => :yes,
		'no  ' => :no,
		'ask ' => :ask,
		
		'case' => :case,
		'diac' => :diacriticals,
		'expa' => :expansion,
		'hyph' => :hyphens,
		'punc' => :punctuation,
		'whit' => :whitespace,
		'nume' => :numeric_strings,
		'rmte' => :application_responses,
	}
	
	Properties = {
		'pcls' => 'class_',
		'ID  ' => 'id_',
	}
	
	Elements = {}
	
	Commands = {
		:quit => ['aevtquit', {
				:saving => 'savo',
				}],
		:activate => ['miscactv', {
				}],
		:run => ['aevtoapp', {
				}],
		:launch => ['ascrnoop', {
				}],
		:open => ['aevtodoc', {
				}],
		:get => ['coregetd', {
				}],
		:print => ['aevtpdoc', {
				}],
		:set => ['coresetd', {
				:to => 'data',
				}],
		:reopen => ['aevtrapp', {
				}],
		:open_location => ['GURLGURL', {
				:window => 'WIND',
				}],
	}

end

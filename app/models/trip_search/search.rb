require 'trip_search/geo/location'

class Search

	attr_accessor :start_location, :end_location, :start_time, :tag_list

	def initialize(options={})
		@start_time = options[:start_time] unless options[:start_time].blank?
		@tag_list = options[:tag_list].blank? ? [] : options[:tag_list]

		@start_location = TripSearch::Geo::Location.new options[:start_location]			
		@tag_list << @start_location.title if @start_location.title

		@end_location = TripSearch::Geo::Location.new options[:end_location]
		@tag_list << @end_location.title if @end_location.title
	end

	def execute
		return Trip.none if invalid?	
		results = base_query.includes(:owner,:tags)
		results = results.order_by_start(@start_location) if @start_location.valid?
		return results
	end

	def invalid?
		!@end_location.valid?
	end

	private

	def base_query		
		Trip.from("
			(
				(#{Trip.active.tagged_with(tag_list, any: true).to_sql}) union
				(#{ends_within_sql})
			) #{Trip.table_name}
		")
	end

	def ends_within_sql
		if @end_location.valid?
			"#{Trip.active.ends_within(@end_location).to_sql}"
		else
			"#{Trip.where('1 = 0').to_sql}"
		end
	end

end
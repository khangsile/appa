require 'trip_search/search'

module Api
	module V1
		class SearchController < Api::ProtectedResourceController

			def create
				Rails.logger.info current_user.to_yaml
				search = Search.new search_params
				@results = search.execute
			end

			private

			def search_params
				params.permit(
					:max_cost,
					:min_seats,
					end_location: [:longitude, :latitude, :title],
					start_location: [:longitude, :latitude, :title],
					tag_list: []
				)
			end

		end
	end
end

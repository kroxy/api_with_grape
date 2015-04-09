module Music
  class Store < Grape::API
    resource :music_stores do
      desc "List all music stores"
      get do
        MusicStore.all
      end


      desc "Create a music store"
      params do
        requires :name, type: String, desc: "Store name"
        optional :address, type: String, desc: "Store address"
        optional :lat, type: Float, desc: "Store latitude"
        optional :lon, type: Float, desc: "Store longitude"
        optional :stars, type: Integer, regexp: /^[0-5]$/, desc: "Store rating (0-5)"
      end
      post do
        MusicStore.create!({
                               name:params[:name],
                               address:params[:address],
                               lat:params[:lat],
                               lon:params[:lon],
                               stars:params[:stars]
                           })
      end


      desc "Update a music store"
      params do
        requires :id, type: String, desc: "Store ID"
        optional :address, type: String, desc: "Store address"
        requires :stars, type: Integer, regexp: /^[0-5]$/, desc: "Store rating"
      end
      put ':id' do
        MusicStore.find(params[:id]).update({
                                                stars:params[:stars],
                                              address:params[:address]
                                            })
      end


      desc "Delete a music store"
      params do
        requires :id, type: String, desc: "Store ID"
      end
      delete ':id' do
        MusicStore.find(params[:id]).destroy!
      end



      desc "Rate the store"
      params do
        requires :id, type: String, desc: "Store ID"
        requires :stars, type: Integer, regexp: /^[0-5]$/, desc: "Store rating"
      end
      put ':id/rate/:stars' do
        MusicStore.find(params[:id]).update({
                                                stars:params[:stars]
                                            })
      end



    end
  end
end
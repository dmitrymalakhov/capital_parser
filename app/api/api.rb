# encoding: utf-8
module API
  class API < Grape::API
  	format :json
  	prefix :api

  	version :v1 do
      resource :stores do

        desc "Список всех доступных ТРЦ"
        get :get_all do
         	Store.all
        end

        desc "Получить ТРЦ по id"
        get :get_by_id do
          array = []
          params[:id].split(",").each do |id|
            if Store.exists?(id)
              array.push(Store.find(id))
            end
          end
          return array
        end
      end

      resource :categories do
        desc "Список категорий всех ТРЦ"
        get :get_all do
          Category.all
        end

        desc "Получить информацию о категории по id"
        get :get_by_id do
          Category.find(params[:id])
        end

        desc "Получить категории ТРЦ"
        get :get_by_store_id do
          Store.find(params[:id]).categories
        end
      end

      resource :pavilions do
        desc "Список павильонов всех ТРЦ"
        get :get_all do
          Pavilion.all
        end

        desc "Получить павильон по id"
        get :get_by_id do
          Pavilion.find(params[:id])
        end

        desc "Получить павильоны ТРЦ (id string => 1,2,3,4)"
        get :get_by_stores_id do
          array = []
          params[:id].split(",").each do |id|
            if Store.exists?(id)
              array.push(Store.find(id).pavilions)
            end
          end
          return array
        end

        desc "Получить павильоны категории"
        get :get_by_category_id do
          Category.find(params[:id]).pavilions
        end
      end

      resource :descriptions do
        desc "Описание всех павильонов"
        get :get_all do
          array = []

          Pavilion.find(:all).each do |pavilion|
            info = [[pavilion.pavilion_description], pavilion.pavilion_gallery, pavilion.discounts, pavilion.credits, [pavilion.region]]
            array.push(info)
          end
          return array
        end

        desc "Получить описание по id"
        get :get_by_id do
          PavilionDescription.find(params[:id])
        end

        desc "Описание павильона"
        get :get_by_pavilion_id do
          pavilion = Pavilion.find(params[:id])
          return [[pavilion.pavilion_description], pavilion.pavilion_gallery, pavilion.discounts, pavilion.credits, [pavilion.region]]
        end

        desc "Описание всех павильонов в ТРЦ"
        get :get_by_store_id do
          array = []
          Store.find(params[:id]).pavilions.each do |pavilion|
            info = [[pavilion.pavilion_description], pavilion.pavilion_gallery, pavilion.discounts, pavilion.credits, [pavilion.region]]
            array.push(info)
          end
          return array
        end
      end
      resource :brands do
        desc "Получить все брэнды"
        get :get_all do
          Brand.all
        end
      end

      resource :news do
        desc "Получить все новости"
        get :get_all do
          News.all
        end

        desc "Получить новости ТРЦ"
        get :get_by_store_id do
          array = []
          Store.find(params[:id]).news.each do |article|
            info = [[article], article.news_gallery]
            array.push(info)
          end
          return array
        end
      end

      resource :films do

        desc "Получить все фильмы"
        get :get_all do
          Film.all
        end

        desc "Получить фильм"
        get :get_by_id do
          Film.find(params[:id])
        end

        desc "Получить все фильмы идущие в кинотеатре ТРЦ"
        get :get_by_store_id do
          ids = Store.find(params[:id]).film_schedules.select(:film_id).pluck(:id).uniq
          Film.where(:id => ids)
        end

        desc "Получить все фильмы идущие в кинотеатре ТРЦ по дате (day, month, year)"
        get :get_by_date_from_store do
          # FilmSchedule.where(:day => params[:day], :month => params[:month], :year => params[:year])
          if Store.exists?(params[:id])
            Store.find(params[:id]).film_schedules.where(:day => params[:day], :month => params[:month], :year => params[:year]).select(:film_id).uniq
          end
        end
      end

      resource :schedules do
        desc "Получить все расписание по всем ТРЦ"
        get :get_all do
          FilmSchedule.all
        end

        desc "Получить расписание по ТРЦ"
        get :get_by_store_id do
          Store.find(params[:id]).film_schedules
        end

        desc "Получить сеанс"
        get :get_by_id do
          FilmSchedule.find(params[:id])
        end

        desc "Получить все сеансы по дате в кинотеатре ТРЦ"
        get :get_by_date_from_store do
          Store.find(params[:id]).film_schedules.where(:day => params[:day], :month => params[:month], :year => params[:year])
        end
      end
    end
  end
end
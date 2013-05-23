# encoding: utf-8
module API
  class API < Grape::API
  	format :xml
  	prefix :api

  	version :v1 do
      resource :stores do

        desc "Список всех доступных ТРЦ"
        get :get_all do
         	Store.all
        end

        desc "Получить информацию о ТРЦ по id"
        get :get_by_id do
          Store.find(params[:id])
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

        desc "Получить павильоны ТРЦ"
        get :get_by_store_id do
          Store.find(params[:id]).pavilions
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
            array.push({
              "description" => pavilion.pavilion_description,
              "gallery" => pavilion.pavilion_gallery,
              "discount" => pavilion.discounts,
              "credit_card" => pavilion.credits
            })
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
          {
            "description" => pavilion.pavilion_description,
            "gallery" => pavilion.pavilion_gallery,
            "discount" => pavilion.discounts,
            "credit_card" => pavilion.credits
          }
        end

        desc "Описание всех павильонов в ТРЦ"
        get :get_by_store_id do
          array = []
          Store.find(params[:id]).pavilions.each do |pavilion|
            array.push({
              "description" => pavilion.pavilion_description,
              "gallery" => pavilion.pavilion_gallery,
              "discount" => pavilion.discounts,
              "credit_card" => pavilion.credits
            })
          end
          return array
        end
      end

      resource :films do
        desc "Получить все фильмы"
        get :get_all

        end
      end
    end
  end
end
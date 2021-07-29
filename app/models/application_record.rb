class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Rails はそのクラス名に対応したデータベースのテーブルを自動的に探そうとする
  # 対応するデータベースのテーブルを用意しない場合に書く
end

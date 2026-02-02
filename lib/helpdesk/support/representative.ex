defmodule Helpdesk.Support.Representative do
  use Ash.Resource,
    domain: helpdesk.Support,
    data_layer: Ash.DataLayer.Ets

  action do
    defaults [:read]

    create :create do
      accept [:name]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
    end
  end

  relationships do
    has_many :tickets, Helpdesk.Support.Ticker
  end
end

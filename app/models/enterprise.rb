class Enterprise < ApplicationRecord
  belongs_to :primary_industry_classification, class_name: 'IndustryClassification', optional: true
  belongs_to :primary_social_intervention_domain, class_name: 'SocialInterventionDomain', optional: true
  belongs_to :enterprise_category, optional: true
  belongs_to :entrepreneur, optional: true
  has_many :uploads

  validates :number, uniqueness: true, presence: true
  validates :application_date, presence: true
  validates :name, presence: true
end

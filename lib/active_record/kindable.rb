#Crea los scopes y las validaciones para cada source
module ActiveRecord
  module Kindable
    include ActiveSupport::Concern
    
    @constant_prefix = nil
    @kinds = nil
    @column_name = nil

    module ClassMethods
      def kindable(column_name, kinds={})
        @column_name = column_name
        @constant_prefix = column_name.upcase
        @kinds = kinds
        kinds.each_pair do |name,value|
          class_eval <<-EOV
            scope :#{column_name}_#{name}, lambda{from_#{column_name}(#{value})}
            #{@constant_prefix}_#{name.upcase} = #{value}
            def #{name}?
              self.#{column_name} == #{value}
            end
          EOV
        end
        class_eval <<-EOV
          validates_inclusion_of :#{column_name}, :in => #{kinds.values}, :if => lambda{|o| !o.#{column_name}.blank?}
          scope :from_#{column_name},  lambda{|k| where(:#{column_name} => k)}
          #{@constant_prefix.to_s.pluralize.upcase} = {#{kinds.keys.map{|name| "#{kinds[name]} => #{name.inspect}"}.join(",")}}
          def self.#{column_name.to_s.pluralize}_for_select(options={})
            values = []
            if options[:include_blank]
              values << [I18n.t("kindable.select"),nil]
            end
            #{@constant_prefix.to_s.pluralize.upcase}.each_pair do |k,v|
              values << [I18n.t("#{table_name}.#{column_name.to_s.pluralize}.\#{v}"),k]
            end
            values    
          end
          
          def get_#{column_name}_name
            I18n.t("#{table_name}.#{column_name.to_s.pluralize}.\#{#{@constant_prefix.to_s.pluralize.upcase}[self.#{column_name}]}")
          end
        EOV
      end  
    end  
  end  
end  

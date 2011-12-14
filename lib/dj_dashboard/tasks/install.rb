require 'rails/generators'

module DjDashboard
  module Tasks
    class Install
      def self.run
        puts 'installing dj_dashboard'
        copy_assets_files
        copy_db_files
        copy_config_files
        run_migrations
      end

      def self.copy_assets_files
        return nil if Rails.version =~ /3.0/ # not needed for rails 3.0
        origin = File.join(gem_path, 'public')
        destination = Rails.root.join('app/assets') if Rails.version =~ /3.1/
        destination = Rails.root.join('public') if Rails.version =~ /3.0/
        puts copy_files(%w( stylesheets images javascripts ), origin, destination, 'dj_dashboard')
      end

      def self.copy_db_files
        puts 'now copying db files'
        origin = File.join(gem_path, 'db')
        destination = Rails.root.join('db')
        puts copy_files(%w( migrate ), origin, destination)
      end

      def self.copy_config_files
        puts 'now copying initializer file'
        origin = File.join(gem_path, 'config')
        destination = Rails.root.join('config')        
        puts copy_files(%w( initializers ), origin, destination)
      end

      def self.gem_path
        File.expand_path('../../..', File.dirname(__FILE__))
      end

      def self.copy_files(directories, origin, destination, prefix = nil)
        directories.each do |directory|
          dirs = [origin, directory, prefix, '**/*'].compact
          Dir[File.join(*dirs)].each do |file|
            relative  = file.gsub(/^#{origin}\//, '')
            dirs = [destination, relative].compact
            dest_file = File.join(*dirs)
            dest_dir  = File.dirname(dest_file)

            if !File.exist?(dest_dir)
              FileUtils.mkdir_p(dest_dir)
            end

            copier.copy_file(file, dest_file) unless File.directory?(file)
          end
        end
      end

      def self.copier
        unless @copier
          Rails::Generators::Base.source_root(gem_path)
          @copier = Rails::Generators::Base.new
        end
        @copier
      end

      def self.run_migrations
        Rake::Task['db:migrate'].invoke
      end

    end
  end
end

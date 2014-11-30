#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

DockerInfo = Struct.new(:path, :image)
BASE_IMAGE_PATTERN = /^FROM\s+(?<base_image>.+)$/
IMAGE_NAME_PATTERN = /^ENV\s+DOCKER_IMAGE_NAME\s+(?<image_name>.+)$/
IMAGE_TAG_PATTERN = /^ENV\s+DOCKER_IMAGE_TAG\s+(?<image_tag>.+)$/


class ImageName 
	attr_reader :name, :tag

	def initialize name, tag=nil
		matched = name.match(/^(?<name>[^:]+)(:(?<tag>.+))?$/)
		raise "wrong name! :#{image_name}" unless matched 
		@name, @tag = matched[:name], matched[:tag]
		if @tag != nil && tag != nil 
			raise "tag is duplicated!"
		end
		@tag = tag unless @tag
		@tag ||= 'latest'	
	end
	def == other
		self.name == other.name && self.tag == other.tag
	end

	def replace_of? other
		self.name == other.name &&
			(self.tag == other.tag || other.tag == 'latest')
	end

	def to_s
		"#{@name}:#{@tag}"
	end
end

class DockerImage 
	attr_reader :dockerfile, :image_name, :base_image_name

	def initialize(dockerfile)
		base_image = image_name = image_tag = nil
		File.open(dockerfile, "r").each_line do |line|
			matched = nil
			base_image = matched[:base_image] if matched = line.match(BASE_IMAGE_PATTERN) 
			image_name = matched[:image_name] if matched= line.match(IMAGE_NAME_PATTERN)
			image_tag = matched[:image_tag] if matched= line.match(IMAGE_TAG_PATTERN)
		end
		@dockerfile = File.absolute_path dockerfile
		@image_name = ImageName.new(image_name, image_tag)
		@base_image_name = ImageName.new(base_image)
	end

	def == other
		@image_name == other.image_name
	end

	def to_s 
		"#{@image_name}"
	end
end

class DockerBuilder
	attr_reader :docker_images, :build_order, :no_deps_images, :results

	BuildResult = Struct.new(:docker_image, :elapsed_time, :success)
	def initialize(path)
		@docker_images = Dir.glob(File.join(path, "**", "Dockerfile")).map {|f| DockerImage.new f}
		all_names = @docker_images.map(&:image_name)
		@no_deps_images = @docker_images.select {|d| ! all_names.find {|x| x.replace_of? d.base_image_name}} 
		@results = []
		make_build_order
	end

	def build 
		pull_base_images
		@build_order.each do |docker|
			build_image docker
		end
		puts 
		puts " Results :"
		@results.each do |result|
			puts "----------------------------------------"
			puts "> image : #{result.docker_image.image_name}"
			puts "> elapsed time : #{result.elapsed_time}"
			puts "> success : #{result.success}"
			puts 
		end
	end

	def build_image docker_image 
		puts ""
		puts "----------------------------------------"
		puts "Build Image : #{docker_image.image_name}"
		puts "----------------------------------------"
		result = BuildResult.new(docker_image)
		Dir.chdir (File.dirname docker_image.dockerfile)
		start = Time.now
		system "docker build -t #{docker_image.image_name} ."
		result.elapsed_time = Time.now - start
		result.success = ($? == 0)
		if docker_image.image_name.tag != 'latest'
			system "docker tag #{docker_image.image_name} #{docker_image.image_name.name}:latest"
		end
		@results << result
		puts "----------------------------------------"
	end

	def pull_base_images
		puts "----------------------------------------"
		puts "Pull Base images"
		puts "----------------------------------------"
		puts 
		@no_deps_images.each do |docker|
			system "docker pull #{docker.base_image_name}"
			if $? != 0 
				puts "Error to pull images :#{docker.base_image_name}"
				exit 1
			end
		end
	end

	private
	def make_build_order
		@build_order = [] + no_deps_images
		while @build_order.size != @docker_images.size
			@build_order += (@docker_images - @build_order).select do |docker|
				@build_order.find do |x|
					x.image_name.replace_of? docker.base_image_name
				end 
			end
		end
	end


end

DockerBuilder.new(File.dirname(__FILE__)).build

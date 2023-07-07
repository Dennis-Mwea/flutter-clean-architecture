.PHONY: all run_dev clean_core clean_domain clean_data clean_presentation clean install_core install_domain install_data install_presentation install build_core build_domain build_data build_presentation build_deps help

all: build_deps run_dev

# Adding a help file: https://gist.github.com/prwhite/8168133#gistcomment-1313022
help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

clean_core:
	@echo "╠ Cleaning the core module..."
	@cd ./core && rm -rf pubspec.lock && flutter clean && flutter pub get

clean_domain:
	@echo "╠ Cleaning the domain module..."
	@cd ./domain && rm -rf pubspec.lock && flutter clean && flutter pub get

clean_data:
	@echo "╠ Cleaning the data module..."
	@cd ./data && rm -rf pubspec.lock && flutter clean && flutter pub get

clean_presentation:
	@echo "╠ Cleaning the presentation module..."
	@cd ./presentation && rm -rf pubspec.lock && flutter clean && flutter pub get

clean: clean_core clean_domain clean_data clean_presentation ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@flutter clean
	@flutter pub get

install_core:
	@echo "╠ Installs packages the core module..."
	@cd ./core && flutter pub get

install_domain:
	@echo "╠ Installs packages the domain module..."
	@cd ./domain && flutter pub get

install_data:
	@echo "╠ Installs packages the data module..."
	@cd ./data && flutter pub get

install_presentation:
	@echo "╠ Installs packages the presentation module..."
	@cd ./presentation && flutter pub get

install: install_core install_domain install_data install_presentation ## Installs package dependencies
	@echo "╠ Installs packages the project..."
	@flutter pub get

build_core: install_core
	@echo "╠ Build core module dependencies..."
	@cd ./core && flutter packages pub run build_runner build --delete-conflicting-outputs

build_domain: install_domain
	@echo "╠ Build domain module dependencies..."
	@cd domain && flutter packages pub run build_runner build --delete-conflicting-outputs

build_data: install_data
	@echo "╠ Build data module dependencies..."
	@cd data && flutter packages pub run build_runner build --delete-conflicting-outputs

build_presentation: install_presentation
	@echo "╠ Build presentation module dependencies..."
	@cd presentation && flutter packages pub run build_runner build --delete-conflicting-outputs

build_deps: build_core build_domain build_data build_presentation ## Installs and builds the dependencies
	@echo "╠ Build app dependencies..."

clean_build_core: clean_core
	@echo "╠ Build core module dependencies..."
	@cd ./core && flutter packages pub run build_runner build --delete-conflicting-outputs

clean_build_domain: clean_domain
	@echo "╠ Build domain module dependencies..."
	@cd domain && flutter packages pub run build_runner build --delete-conflicting-outputs

clean_build_data: clean_data
	@echo "╠ Build data module dependencies..."
	@cd data && flutter packages pub run build_runner build --delete-conflicting-outputs

clean_build_presentation: clean_presentation
	@echo "╠ Build presentation module dependencies..."
	@cd presentation && flutter packages pub run build_runner build --delete-conflicting-outputs

clean_build_deps: clean_build_core clean_build_domain clean_build_data clean_build_presentation ## Cleans, installs and builds dependencies
	@echo "╠ Build app dependencies..."

run_dev: build_deps ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run

require_dependency "no_cms/admin/widgets/application_controller"

module NoCms::Admin::Widgets
  class WidgetsController < ApplicationController

    before_action :load_menu_section
    before_action :load_widget, only: [:edit, :update, :destroy]
    before_action :load_sidebar, only: [:index, :new, :edit]


    def new
      @widget = NoCms::Widgets::Widget.new
      build_blocks
    end

    def create
      @widget = NoCms::Widgets::Widget.new widget_params
      if @widget.save
        @nocms_logger.info(I18n.t('.no_cms.admin.widgets.widgets.create.success', slug: @widget.slug), true)
        redirect_to edit_widget_path(@widget)
      else
        @nocms_logger.error(I18n.t('.no_cms.admin.widgets.widgets.create.error', slug: @widget.slug))
        load_sidebar
        render :new
      end
    end

    def edit
      build_blocks
      @nocms_logger.add_message :widgets, I18n.t('.no_cms.admin.widgets.widgets.edit.log_messages', slug: @widget.slug)
    end

    def update
      if @widget.update_attributes widget_params
        @nocms_logger.info(I18n.t('.no_cms.admin.widgets.widgets.update.success', slug: @widget.slug), true)
        redirect_to edit_widget_path(@widget)
      else
        @nocms_logger.error(I18n.t('.no_cms.admin.widgets.widgets.update.error', slug: @widget.slug))
        load_sidebar
        render :edit
      end
    end

    def destroy
      if @widget.destroy
        @nocms_logger.info(I18n.t('.no_cms.admin.widgets.widgets.destroy.success', slug: @widget.slug), true)
      else
        @nocms_logger.error(I18n.t('.no_cms.admin.widgets.widgets.destroy.error', slug: @widget.slug), true)
      end
      redirect_to widgets_path
    end

    private

    def load_menu_section
      @current_section = 'widgets'
    end

    def load_widget
      @widget = NoCms::Widgets::Widget.find(params[:id])
    end

    def load_sidebar
      @widgets = NoCms::Widgets::Widget.all
    end

    def build_blocks
      NoCms::Blocks.block_layouts.each do |name, _|
        @widget.blocks.build layout: name
      end
    end

    def widget_params
      widget_params = params.require(:widget).permit(:slug, blocks_ids: [])
      widget_params.merge!(blocks_attributes: params[:widget][:blocks_attributes]) unless params[:widget][:blocks_attributes].blank?
      widget_params
    end

  end
end
require 'spec_helper'

describe NoCms::Admin::Widgets do

  let(:widget) { create(:nocms_widget) }

  before { widget }

  subject { page }

  describe 'index' do
    before { visit no_cms_admin_widgets.widgets_path }

    context 'when visiting admin widget' do
      it("status code should be 200") { expect(page.status_code).to be 200 }
      it("should display widget's slug") { expect(page).to have_content widget.slug }
    end

    context 'when deleting widget' do
      before { find('.ico-mini-delete').click }

      it("status code should be 200") { expect(page.status_code).to be 200 }
      it('current path should be widgets path') { expect(current_path).to match no_cms_admin_widgets.widgets_path }
      it('widget should be removed') { expect(page).to have_no_content widget.slug }
    end
  end

  describe 'create', js: true do
    before { visit no_cms_admin_widgets.new_widget_path }

    context 'when visiting new widget form' do
      it("status code should be 200") { expect(page.status_code).to be 200 }


      context 'and create new widget' do
        let(:slug) { Faker::Lorem.sentence }

        context 'with valid values' do
          before do
            fill_in "widget[slug]", with: slug
            click_button I18n.t('no_cms.admin.widgets.widgets.toolbar_right.submit')
          end

          it("status code should be 200") { expect(page.status_code).to be 200 }
          it('current path should be edit widget path') { expect(current_path).to match no_cms_admin_widgets.edit_widget_path(NoCms::Widgets::Widget.last) }
          it('should not display errors') { expect(page).to have_no_content I18n.t('no_cms.admin.widgets.widgets.error', slug: '') }
          it("should display widget's slug") { expect(page).to have_content slug.parameterize }
        end

        context 'with invalid values' do
          before { click_button I18n.t('no_cms.admin.widgets.widgets.toolbar_right.submit') }

          it("status code should be 200") { expect(page.status_code).to be 200 }
          it('current path should be widgets path') { expect(current_path).to match no_cms_admin_widgets.widgets_path }
          it('should display errors') { expect(page).to have_content I18n.t('no_cms.admin.widgets.widgets.create.error', slug: '') }
        end
      end
    end
  end

  describe 'update', js: true do
    before { visit no_cms_admin_widgets.edit_widget_path(widget) }

    context 'when visiting edit widget form' do
      it("status code should be 200") { expect(page.status_code).to be 200 }

      context 'and update widget' do
        let(:slug) { Faker::Lorem.sentence }

        context 'with valid values' do
          before do
            fill_in "widget[slug]", with: slug
            click_button I18n.t('no_cms.admin.widgets.widgets.toolbar_right.submit')
          end

          it("status code should be 200") { expect(page.status_code).to be 200 }
          it('current path should be edit widget path') { expect(current_path).to match no_cms_admin_widgets.edit_widget_path(NoCms::Widgets::Widget.last) }
          it('should not display errors') { expect(page).to have_no_content I18n.t('no_cms.admin.widgets.widgets.update.error', slug: slug) }
          it('should display new slug') { expect(page).to have_content slug.parameterize }
        end

        context 'with invalid values' do
          before do
            fill_in "widget[slug]", with: ''
            click_button I18n.t('.no_cms.admin.widgets.widgets.toolbar_right.submit')
          end

          it("status code should be 200") { expect(page.status_code).to be 200 }
          it('current path should be widget path') { expect(current_path).to match no_cms_admin_widgets.widget_path(NoCms::Widgets::Widget.last) }
          it('should display errors') { expect(page).to have_content I18n.t('no_cms.admin.widgets.widgets.update.error', slug: '') }
        end
      end
    end
  end
end
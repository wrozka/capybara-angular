module Capybara
  module Angular
    def ng_fill_in(target, opts)
      if opts.is_a?(String)
        opts = { with: opts }
      end

      find("input[ng-model='#{target}']").set(opts[:with])
    end

    def ng_click_on(target)
      begin
        find('*[ui-sref]', text: target)
      rescue Capybara::ElementNotFound
        find('*[ng-click]', text: target)
      end.click
    end

    def ng_ionic_click_left_nav
      find('ion-header-bar .buttons-left button').click
    end

    def ng_ionic_click_right_nav
      find('ion-header-bar .buttons-right button').click
    end


    def ng_ionic_list_item_click_on(target)
      # find(:xpath, "//ion-side-menu-content/descendant::ion-item/descendant-or-self::*[contains(text(), '#{target}')]/ancestor-or-self::ion-item").click
      find(:xpath, "//ion-side-menu-content/descendant::ion-item/descendant-or-self::*[text()[contains(., '#{target}')]]/ancestor-or-self::ion-item").click
    end
  end
end

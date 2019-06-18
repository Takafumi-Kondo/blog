module ApplicationHelper
	require "redcarpet"
	require "coderay"


	class HTMLwithCoderay < Redcarpet::Render::HTML
		def block_code(code, language)
			language = language.split(':')[0]

			case language.to_s
            when 'rb'
                lang = 'ruby'
            when 'yml'
                lang = 'yaml'
            when 'css'
                lang = 'css'
            when 'html'
                lang = 'html'
            when ''
                lang = 'md'
            else
                lang = language
            end

            CodeRay.scan(code, lang).div
        end
	end

	def markdown(text)
        html_render = HTMLwithCoderay.new(filter_html: true)#ユーザー入力HTMLを出力をしない
        options = {
            autolink: true,
            space_after_headers: true,
            no_intra_emphasis: true,#単語中の強調を認識しない
            fenced_code_blocks: true,#```に囲まれた部分をコードとしてできる
            tables: true,
            hard_wrap: true,#行末にスペース2ついれなくても改行できるように
            xhtml: true,#xhtml のタグを出力する
            lax_html_blocks: true,#HTMLブロックの上下に改行不要
            strikethrough: true#取り消し線(~)を解析する
        }
        markdown = Redcarpet::Markdown.new(html_render, options)#オプション内容渡している
        markdown.render(text)
    end
end

<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">2014-{{ current }}</span>
  <span class="with-love">
    <i class="icon-next-heart fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<div class="copyright" >
  <span class="author" itemprop="copyrightHolder">使用本站文章时请遵守<a href="http://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank">CC BY-NC-ND 4.0</a>协议。</span>
</div>

<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT{% if theme.scheme %}.{{ theme.scheme }}{% endif %}
  </a>
</div>

{% if theme.use_font_lato %}
<script type="text/javascript">
  {% if config.language === 'zh-Hans' %}
    loadCSS('//fonts.lug.ustc.edu.cn/css?family=Lato:300,400,700,400italic&subset=latin,latin-ext');
  {% else %}
    loadCSS('//fonts.googleapis.com/css?family=Lato:300,400,700,400italic&subset=latin,latin-ext');
  {% endif %}
</script>
{% endif %}

{% block footer %}{% endblock %}

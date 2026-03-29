defmodule SocialWeb.PageLive do
  use SocialWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-base-100">
        <!-- Hero Section -->
        <section class="relative overflow-hidden bg-gradient-to-br from-primary/5 via-base-100 to-secondary/5 py-20 px-4">
          <!-- Background Pattern -->
          <div class="absolute inset-0 opacity-30">
            <svg class="h-full w-full" xmlns="http://www.w3.org/2000/svg">
              <defs>
                <pattern id="grid" width="40" height="40" patternUnits="userSpaceOnUse">
                  <circle cx="20" cy="20" r="1" fill="currentColor" class="text-primary/20" />
                </pattern>
              </defs>
              <rect width="100%" height="100%" fill="url(#grid)" />
            </svg>
          </div>

          <div class="relative mx-auto max-w-6xl">
            <div class="text-center mb-12">
              <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 text-primary mb-6">
                <.icon name="hero-sparkles" class="w-5 h-5" />
                <span class="text-sm font-medium">Social Tools by TremTec</span>
              </div>

              <h1 class="text-5xl md:text-6xl font-bold text-base-content mb-6">
                Gestão Social <span class="text-primary">Inteligente</span>
              </h1>

              <p class="text-xl text-base-content/70 max-w-2xl mx-auto mb-8">
                Plataforma completa para gestão de ONGs, voluntários, doações e eventos sociais.
                Simplifique sua operação com tecnologia humanizada.
              </p>

              <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <.social_button variant="primary" size="lg">
                  <.icon name="hero-rocket-launch" class="w-5 h-5 mr-2" /> Começar Agora
                </.social_button>
                <.social_button variant="ghost" size="lg">
                  <.icon name="hero-play" class="w-5 h-5 mr-2" /> Ver Demo
                </.social_button>
              </div>
            </div>
          </div>
        </section>
        
    <!-- Design System Showcase -->
        <section class="py-16 px-4">
          <div class="mx-auto max-w-6xl">
            <div class="text-center mb-12">
              <h2 class="text-3xl font-bold text-base-content mb-4">Design System</h2>
              <p class="text-base-content/60 max-w-xl mx-auto">
                Componentes reutilizáveis construídos com Tailwind CSS e DaisyUI,
                com cores quentes inspiradas na cultura brasileira.
              </p>
            </div>
            
    <!-- Components Grid -->
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              <!-- Buttons Showcase -->
              <.social_card padding="small">
                <div class="space-y-3">
                  <h3 class="font-semibold text-base-content">Botões</h3>
                  <div class="flex flex-wrap gap-2">
                    <.social_button variant="primary" size="sm">Primary</.social_button>
                    <.social_button variant="secondary" size="sm">Secondary</.social_button>
                    <.social_button variant="ghost" size="sm">Ghost</.social_button>
                    <.social_button variant="danger" size="sm">Danger</.social_button>
                  </div>
                  <div class="flex flex-wrap gap-2">
                    <.social_button variant="primary" size="md">Medium</.social_button>
                    <.social_button variant="primary" size="lg">Large</.social_button>
                  </div>
                </div>
              </.social_card>
              
    <!-- Badges Showcase -->
              <.social_card padding="small">
                <div class="space-y-3">
                  <h3 class="font-semibold text-base-content">Badges</h3>
                  <div class="flex flex-wrap gap-2">
                    <.social_badge variant="primary">Primary</.social_badge>
                    <.social_badge variant="secondary">Secondary</.social_badge>
                    <.social_badge variant="success">Success</.social_badge>
                    <.social_badge variant="warning">Warning</.social_badge>
                    <.social_badge variant="error">Error</.social_badge>
                    <.social_badge variant="info">Info</.social_badge>
                  </div>
                </div>
              </.social_card>
              
    <!-- Avatar Showcase -->
              <.social_card padding="small">
                <div class="space-y-3">
                  <h3 class="font-semibold text-base-content">Avatares</h3>
                  <div class="flex items-center gap-3">
                    <.social_avatar src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix" />
                    <.social_avatar
                      src="https://api.dicebear.com/7.x/avataaars/svg?seed=Aneka"
                      size="lg"
                    />
                    <.social_avatar
                      src="https://api.dicebear.com/7.x/avataaars/svg?seed=Jack"
                      size="xl"
                    />
                    <.social_avatar name="TremTec" size="lg" />
                  </div>
                </div>
              </.social_card>
              
    <!-- Stats Showcase -->
              <.social_card padding="small">
                <div class="space-y-3">
                  <h3 class="font-semibold text-base-content">Estatísticas</h3>
                  <div class="grid grid-cols-2 gap-3">
                    <.social_stat
                      title="Voluntários"
                      value="1,234"
                      trend="up"
                      trend_value="+12%"
                    />
                    <.social_stat
                      title="Doações"
                      value="R$ 45K"
                      trend="up"
                      trend_value="+8%"
                    />
                  </div>
                </div>
              </.social_card>
              
    <!-- Alerts Showcase -->
              <.social_card padding="small">
                <div class="space-y-3">
                  <h3 class="font-semibold text-base-content">Alertas</h3>
                  <.social_alert variant="success" title="Sucesso!">
                    Operação realizada com sucesso.
                  </.social_alert>
                  <.social_alert variant="warning" title="Atenção!">
                    Verifique os dados antes de continuar.
                  </.social_alert>
                </div>
              </.social_card>
              
    <!-- Empty State Showcase -->
              <.social_card padding="small">
                <div class="space-y-3">
                  <h3 class="font-semibold text-base-content">Empty State</h3>
                  <.social_empty_state
                    icon="hero-users"
                    title="Nenhum voluntário encontrado"
                    description="Comece cadastrando novos voluntários para sua organização."
                  >
                    <.social_button variant="primary" size="sm">
                      <.icon name="hero-plus" class="w-4 h-4 mr-1" /> Adicionar
                    </.social_button>
                  </.social_empty_state>
                </div>
              </.social_card>
            </div>
          </div>
        </section>
        
    <!-- Features Section -->
        <section class="py-16 px-4 bg-base-200/50">
          <div class="mx-auto max-w-6xl">
            <div class="text-center mb-12">
              <h2 class="text-3xl font-bold text-base-content mb-4">Funcionalidades</h2>
              <p class="text-base-content/60 max-w-xl mx-auto">
                Tudo que você precisa para gerenciar sua organização social.
              </p>
            </div>

            <div class="grid md:grid-cols-3 gap-6">
              <.social_card glass hover>
                <div class="text-center">
                  <div class="inline-flex items-center justify-center w-14 h-14 rounded-full bg-primary/10 text-primary mb-4">
                    <.icon name="hero-users" class="w-7 h-7" />
                  </div>
                  <h3 class="text-lg font-semibold text-base-content mb-2">Gestão de Voluntários</h3>
                  <p class="text-base-content/60 text-sm">
                    Cadastre, organize e acompanhe atividades dos voluntários da sua organização.
                  </p>
                </div>
              </.social_card>

              <.social_card glass hover>
                <div class="text-center">
                  <div class="inline-flex items-center justify-center w-14 h-14 rounded-full bg-secondary/10 text-secondary mb-4">
                    <.icon name="hero-heart" class="w-7 h-7" />
                  </div>
                  <h3 class="text-lg font-semibold text-base-content mb-2">Controle de Doações</h3>
                  <p class="text-base-content/60 text-sm">
                    Gerencie doações financeiras e de materiais com transparência total.
                  </p>
                </div>
              </.social_card>

              <.social_card glass hover>
                <div class="text-center">
                  <div class="inline-flex items-center justify-center w-14 h-14 rounded-full bg-warning/10 text-warning mb-4">
                    <.icon name="hero-calendar" class="w-7 h-7" />
                  </div>
                  <h3 class="text-lg font-semibold text-base-content mb-2">
                    Planejamento de Eventos
                  </h3>
                  <p class="text-base-content/60 text-sm">
                    Organize eventos e campanhas com ferramentas de planejamento integradas.
                  </p>
                </div>
              </.social_card>
            </div>
          </div>
        </section>
        
    <!-- CTA Section -->
        <section class="py-20 px-4">
          <div class="mx-auto max-w-4xl text-center">
            <.social_card glass>
              <h2 class="text-3xl font-bold text-base-content mb-4">
                Pronto para transformar sua gestão social?
              </h2>
              <p class="text-base-content/60 mb-8 max-w-xl mx-auto">
                Junte-se a centenas de organizações que já utilizam a Social Tools
                para fazer a diferença na sociedade.
              </p>
              <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <.social_button variant="primary" size="lg">
                  <.icon name="hero-user-plus" class="w-5 h-5 mr-2" /> Criar Conta Grátis
                </.social_button>
                <.social_button variant="ghost" size="lg">
                  <.icon name="hero-chat-bubble-left" class="w-5 h-5 mr-2" /> Falar com Consultor
                </.social_button>
              </div>
            </.social_card>
          </div>
        </section>
        
    <!-- Footer -->
        <footer class="py-8 px-4 border-t border-base-200">
          <div class="mx-auto max-w-6xl flex flex-col md:flex-row justify-between items-center gap-4">
            <div class="flex items-center gap-2 text-base-content/60">
              <.icon name="hero-heart" class="w-5 h-5 text-secondary" />
              <span>Social Tools by TremTec</span>
            </div>
            <div class="flex items-center gap-4">
              <Layouts.theme_toggle />
            </div>
          </div>
        </footer>
      </div>
    </Layouts.app>
    """
  end
end

# Estágio Curricular - Engenharia Informática (UÉvora)
## DigitalWorks by PlexusTech - Mobile Development

---

**Estudante:** Francisco Rodrigues - l59119

**Universidade:** Universidade de Évora

**Empresa:** DigitalWorks by PlexusTech

**Responsável:** Eduardo Flores

**Tutor:** João Rouxinol

---
### Objetivos do Estágio

Neste estágio tive uma introdução prática ao desenvolvimento de aplicações móveis, participando na construção de dois trabalhos desenvolvidos em Flutter.

## Projetos

### 1. Flutter App Base

O projeto **Flutter App Base** serve como base de arquitetura para aplicações Flutter, com uma estrutura organizada em camadas e suporte a componentes essenciais:

- Arquitectura de módulos separando `core`, `data`, `domain` e `presentation`.
- Utilização de `go_router` para gestão de rotas.
- Internacionalização com suporte a **pt**, **es** e **en**.
- Injeção de dependências via um padrão de `initInjector()`.

Este trabalho demonstra a configuração inicial de uma app Flutter moderna, pronta para evoluir com novas funcionalidades e integrações.

### 2. Poke API

O projeto **poke_api** é uma aplicação Flutter de consulta a Pokémons, com uma interface orientada a bloc's e funcionalidades de navegação e favoritos.

Funcionalidades principais:

- Listagem de Pokémons com carregamento inicial automático.
- Página de detalhes para cada Pokémon.
- Gestão de favoritos com uma secção dedicada de favoritos.
- Navegação fluida entre ecrãs usando `GoRouter`.
- Arquitetura baseada em `flutter_bloc`, `get_it` e `provider`.
- Suporte a temas e traduções.

## Estrutura dos Projetos

- `Flutter App Base/` - Template de Flutter com organização por camadas e configuração de rotas.
- `poke_api/` - Aplicação funcional com lógica de apresentação, dados e domínio, focada na experiência de consulta a Pokémons.

## Tecnologias Utilizadas

- Flutter
- Dart
- Flutter BLoC
- GoRouter
- GetIt
- Provider
- Shared Preferences
- Localizações (pt, es, en)

## Como Abrir os Projetos

1. Abre o Android Studio.
2. Abre a pasta do projeto desejado:
   - `Flutter App Base/`
   - `poke_api/`
3. Executa `flutter pub get` para instalar dependências.
4. Inicia a aplicação em emulador ou dispositivo físico.

## Observações

Estes dois trabalhos fazem parte do estágio curricular e representam o desenvolvimento de conhecimento em Flutter, arquitetura de aplicações móveis e integração de navegação, temas e localização.

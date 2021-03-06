require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let (:user) { create(:user) }
  let (:wiki) { create(:wiki, user: user) }
  let (:built_wiki) { build(:wiki, user: user) }

  context "signed-in user" do
    before do
      sign_in(user)
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: { id: wiki.id }
        wiki_instance = assigns(:wiki)
        expect(wiki_instance.id).to eq(wiki.id)
        expect(wiki_instance.title).to eq(wiki.title)
        expect(wiki_instance.body).to eq(wiki.body)
      end
    end

    describe "POST create" do
      it "increases the number of wiki by 1" do
	      expect( -> { post :create, params: { wiki: { title: built_wiki.title, body: built_wiki.body }}} ).to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: { title: built_wiki.title, body: built_wiki.body }}
        expect(assigns(:wiki)).to eq(Wiki.last)
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: built_wiki.title, body: built_wiki.body }}
        expect(response).to redirect_to(Wiki.last)
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = "This is a new title"
        new_body = "This is a random paragraph that probably has lots and lots of spelling errors in it because I can't spell well."
        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body }}
        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq(wiki.id)
        expect(updated_wiki.title).to eq(new_title)
        expect(updated_wiki.body).to eq(new_body)
      end

      it "redirects to the updated wiki" do
        new_title = "This is a new title"
        new_body = "This is a random paragraph that probably has lots and lots of spelling errors in it because I can't spell well."
        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body }}
        expect(response).to redirect_to [wiki]
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: { id: wiki.id }
        count = Wiki.where({id: wiki.id}).size
        expect(count).to eq 0
      end
    end
  end
end

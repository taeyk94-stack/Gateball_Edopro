--X－セイバー ウルズ
function c102000023.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(102000023,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCondition(c102000023.tdcon)
	e1:SetCost(c102000023.tdcost)
	e1:SetTarget(c102000023.tdtg)
	e1:SetOperation(c102000023.tdop)
	c:RegisterEffect(e1)
end
function c102000023.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local t=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(t)
	return aux.bdogcon(e,tp,eg,ep,ev,re,r,rp)
end
function c102000023.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c102000023.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=e:GetLabelObject()
	if chk==0 then return t:IsAbleToDeck() end
	t:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,t,1,0,0)
end
function c102000023.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end

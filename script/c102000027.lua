--六武衆の師範
function c102000027.initial_effect(c)
	c:SetUniqueOnField(1,0,102000027)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c102000027.spcon)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(102000027,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c102000027.thcon)
	e2:SetTarget(c102000027.thtg)
	e2:SetOperation(c102000027.thop)
	c:RegisterEffect(e2)
end
function c102000027.spfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3d)
end
function c102000027.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c102000027.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c102000027.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
    if c:IsReason(REASON_BATTLE) then return false end
    if not c:IsPreviousControler(tp) then return false end
    local reff=re:GetHandler()
    if not reff then return false end
    return reff:GetControler()==1-tp
end
function c102000027.filter(c)
	return c:IsSetCard(0x3d) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c102000027.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c102000027.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c102000027.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c102000027.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end

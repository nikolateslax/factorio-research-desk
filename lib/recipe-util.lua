-- 
-- Simplified/modified version of data_util.lua from bz mods
-- Most part written by Brevven https://mods.factorio.com/user/brevven
-- 

local util = {}


function util.set_enabled(recipe_name, enabled)
	if data.raw.recipe[recipe_name] then
		if data.raw.recipe[recipe_name].normal then data.raw.recipe[recipe_name].normal.enabled = enabled end
		if data.raw.recipe[recipe_name].expensive then data.raw.recipe[recipe_name].expensive.enabled = enabled end
		if not data.raw.recipe[recipe_name].normal then data.raw.recipe[recipe_name].enabled = enabled end
	end
end


-- Set/override a technology's prerequisites
function util.set_prerequisite(technology_name, prerequisites)
	local technology = data.raw.technology[technology_name]
	if technology then
		technology.prerequisites = {}
		for i, prerequisite in pairs(prerequisites) do
			if data.raw.technology[prerequisite] then
				table.insert(technology.prerequisites, prerequisite)
			end
		end
	end
end

-- Add a prerequisite to a given technology
function util.add_prerequisite(technology_name, prerequisite)
	local technology = data.raw.technology[technology_name]
	if technology and data.raw.technology[prerequisite] then
		if technology.prerequisites then
			table.insert(technology.prerequisites, prerequisite)
		else
			technology.prerequisites = {prerequisite}
		end
	end
end

-- Remove a prerequisite from a given technology
function util.remove_prerequisite(technology_name, prerequisite)
	local technology = data.raw.technology[technology_name]
	local index = -1
	if technology then
		for i, prereq in pairs(technology.prerequisites) do
			if prereq == prerequisite then
				index = i
				break
			end
		end
		if index > -1 then
			table.remove(technology.prerequisites, index)
		end
	end
end



-- Add an effect to a given technology
function util.add_effect(technology_name, effect)
	local technology = data.raw.technology[technology_name]
	if technology then
		if not technology.effects then technology.effects = {} end
		if effect and effect.type == "unlock-recipe" then
			if not data.raw.recipe[effect.recipe] then
				return
			end
			table.insert(technology.effects, effect)
		end
	end
end

-- Add an effect to a given technology to unlock recipe
function util.add_unlock(technology_name, recipe)
	util.add_effect(technology_name, {type="unlock-recipe", recipe=recipe})
end

-- remove recipe unlock effect from a given technology
function util.remove_recipe_effect(technology_name, recipe_name)
	local technology = data.raw.technology[technology_name]
	local index = -1
	local cnt = 0
	if technology and technology.effects then
		for i, effect in pairs(technology.effects) do
			if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
				index = i
				cnt = cnt + 1
			end
		end
		if index > -1 then
			table.remove(technology.effects, index)
			if cnt > 1 then -- not over yet, do it again
				util.remove_recipe_effect(technology_name, recipe_name)
			end
		end
	end
end


function util.remove_all_recipe_effects(recipe_name)
	for name, _ in pairs(data.raw.technology) do
		util.remove_recipe_effect(name, recipe_name)
	end
end


function util.add_unlock_force(technology_name, recipe)
	util.set_enabled(recipe, false)
	util.remove_all_recipe_effects(recipe)
	util.add_unlock(technology_name, recipe)
end


-- Add a given quantity of ingredient to a given recipe
function util.add_ingredient(recipe_name, ingredient, quantity)
	local is_fluid = not not data.raw.fluid[ingredient]
	if data.raw.recipe[recipe_name] and (data.raw.item[ingredient] or is_fluid) then
		add_ingredient(data.raw.recipe[recipe_name], ingredient, quantity, is_fluid)
		add_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity, is_fluid)
		add_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity, is_fluid)
	end
end

function add_ingredient(recipe, ingredient, quantity, is_fluid)
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, existing in pairs(recipe.ingredients) do
			if existing[1] == ingredient or existing.name == ingredient then
				return
			end
		end
		if is_fluid then
			table.insert(recipe.ingredients, {type="fluid", name=ingredient, amount=quantity})
		else
			table.insert(recipe.ingredients, {ingredient, quantity})
		end
	end
end

-- Remove an ingredient from a recipe
function util.remove_ingredient(recipe_name, old)
	if data.raw.recipe[recipe_name] then
		remove_ingredient(data.raw.recipe[recipe_name], old)
		remove_ingredient(data.raw.recipe[recipe_name].normal, old)
		remove_ingredient(data.raw.recipe[recipe_name].expensive, old)
	end
end

function remove_ingredient(recipe, old)
	index = -1
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old or ingredient[1] == old then
				index = i
				break
			end
		end
		if index > -1 then
			table.remove(recipe.ingredients, index)
		end
	end
end


-- Replace one ingredient with another in a recipe
--		Use amount to set an amount. If that amount is a multiplier instead of an exact amount, set multiply true.
function util.replace_ingredient(recipe_name, old, new, amount, multiply)
--	if bypass(recipe_name) then return end
	if data.raw.recipe[recipe_name] and (data.raw.item[new] or data.raw.fluid[new]) then
--		me.add_modified(recipe_name)
		replace_ingredient(data.raw.recipe[recipe_name], old, new, amount, multiply)
		replace_ingredient(data.raw.recipe[recipe_name].normal, old, new, amount, multiply)
		replace_ingredient(data.raw.recipe[recipe_name].expensive, old, new, amount, multiply)
	end
end

function replace_ingredient(recipe, old, new, amount, multiply)
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, existing in pairs(recipe.ingredients) do
			if existing[1] == new or existing.name == new then
				return
			end
		end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then 
				ingredient.name = new 
				if amount then
					if multiply then
						ingredient.amount = amount * ingredient.amount
					else
						ingredient.amount = amount
					end
				end
			end
			if ingredient[1] == old then 
				ingredient[1] = new
				if amount then
					if multiply then
						ingredient[2] = amount * ingredient[2]
					else
						ingredient[2] = amount
					end
				end
			end
		end
	end
end



function util.replace_ingredients_prior_to(tech, old, new, multiplier)
	if not data.raw.technology[tech] then
		log("Not replacing ingredient "..old.." with "..new.." because tech "..tech.." was not found")
		return
	end
	
	for i, recipe in pairs(data.raw.recipe) do
		if recipe.enabled and recipe.enabled ~= 'false' then 
			util.replace_ingredient(recipe.name, old, new, multiplier, true)
		end
	end
	
	for curr_tech_name, curr_tech in pairs (data.raw.technology) do
		if curr_tech_name ~= tech and curr_tech.effects and not technology_has_ancestor(curr_tech_name, tech) then
			for _, effect in pairs(curr_tech.effects) do
				if effect.type == "unlock-recipe" then
					util.replace_ingredient(effect.recipe, old, new, multiplier, true)
				end
			end
		end
	end
end

function technology_has_ancestor(current, ancestor)
	local tech = data.raw.technology[current]
	if tech.prerequisites then
		for _, prereq in pairs(tech.prerequisites) do
			if prereq == ancestor or technology_has_ancestor(prereq, ancestor) then
				return true
			end
		end
	end
	return false
end

return util

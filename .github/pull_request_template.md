# Infrastructure Change Request

## 📋 Change Summary
<!-- Provide a brief description of the infrastructure changes -->

**What is being changed:**
- [ ] New resources
- [ ] Resource modifications  
- [ ] Resource deletions
- [ ] Configuration updates
- [ ] Other: ___________

**Impact Level:**
- [ ] Low (minor config changes, no downtime)
- [ ] Medium (resource updates, brief potential impact)
- [ ] High (significant changes, planned downtime)
- [ ] Critical (major infrastructure changes)

## 🧪 Testing & Validation

### Development Environment Testing
- [ ] **I have tested these changes in a development environment**
- [ ] **I have verified the Terraform plan output**
- [ ] **I have confirmed all resources will be created/updated as expected**

### Destructive Changes
- [ ] **This PR contains NO destructive changes** (resource deletions, replacements, or data loss)
- [ ] **This PR contains destructive changes** (if checked, complete section below)

#### ⚠️ Destructive Changes Declaration
<!-- Only complete if destructive changes are present -->
**Resources that will be destroyed/replaced:**
- 

**Data that may be lost:**
- 

**Mitigation steps taken:**
- [ ] Backups created
- [ ] Data migration plan in place
- [ ] Rollback procedure documented
- [ ] Team coordination completed

**I acknowledge that:**
- [ ] I understand the impact of these destructive changes
- [ ] I have coordinated with the team about potential downtime
- [ ] I have a rollback plan if issues occur

## 📊 Terraform Plan Output
<!-- Paste the output of `terraform plan` here -->
```hcl
# Paste terraform plan output here
```

## 🔍 Pre-Merge Checklist
- [ ] Code follows Terraform best practices
- [ ] All required variables are documented
- [ ] Outputs are properly defined
- [ ] Resource naming follows conventions
- [ ] Tags are applied consistently
- [ ] Security considerations reviewed
- [ ] Cost impact assessed

## 🚀 Deployment Notes
<!-- Any special instructions for deployment -->

**Post-deployment verification steps:**
1. 
2. 
3. 

**Rollback procedure (if needed):**
1. 
2. 
3. 

---

**Reviewer Checklist:**
- [ ] Infrastructure changes reviewed and approved
- [ ] Security implications considered
- [ ] Cost impact acceptable
- [ ] Testing evidence provided
- [ ] Destructive changes (if any) properly justified and coordinated
